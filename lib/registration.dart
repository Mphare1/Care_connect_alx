import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cityController = TextEditingController();
  final _rateController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _medicalHistoryController = TextEditingController();

  String? _selectedRole;
  final List<String> _cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    _rateController.dispose();
    _dateOfBirthController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Registration"),
        centerTitle: true,
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              _buildTextField(_fullNameController, "Full Name", Icons.person),
              const SizedBox(height: 15),
              _buildTextField(_emailController, "Email", Icons.email),
              const SizedBox(height: 15),
              _buildTextField(_passwordController, "Password", Icons.lock,
                  obscureText: true),
              const SizedBox(height: 30),
              const Text(
                "Register as:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              _buildRoleSelection(),
              const SizedBox(height: 20),
              if (_selectedRole == "Doctor") ...[
                _buildDropdownField("City", _cities, _cityController),
                const SizedBox(height: 15),
                _buildTextField(
                  _rateController,
                  "Consultation Rate (\$)",
                  Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
              ],
              if (_selectedRole == "Patient") ...[
                _buildDateField("Date of Birth", _dateOfBirthController),
                const SizedBox(height: 15),
                _buildTextField(
                  _medicalHistoryController,
                  "Medical History (optional)",
                  Icons.notes,
                  maxLines: 3,
                ),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission here
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for standard text fields with icons
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.teal[600]),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        return null;
      },
    );
  }

  // Role selection with Radio buttons
  Widget _buildRoleSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: RadioListTile(
            title: const Text("Doctor"),
            value: "Doctor",
            groupValue: _selectedRole,
            activeColor: Colors.teal[600],
            onChanged: (value) {
              setState(() {
                _selectedRole = value as String?;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: const Text("Patient"),
            value: "Patient",
            groupValue: _selectedRole,
            activeColor: Colors.teal[600],
            onChanged: (value) {
              setState(() {
                _selectedRole = value as String?;
              });
            },
          ),
        ),
      ],
    );
  }

  // Dropdown field for selecting city
  Widget _buildDropdownField(
      String label, List<String> items, TextEditingController controller) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: (value) {
        setState(() {
          controller.text = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select a city";
        }
        return null;
      },
    );
  }

  // Date picker for Date of Birth
  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today, color: Colors.teal[600]),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          controller.text = "${date.toLocal()}".split(' ')[0];
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your date of birth";
        }
        return null;
      },
    );
  }
}
