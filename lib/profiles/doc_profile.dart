import 'package:flutter/material.dart';

class DocProfiles extends StatefulWidget {
  const DocProfiles({super.key});

  @override
  State<DocProfiles> createState() => _DocProfilesState();
}

class _DocProfilesState extends State<DocProfiles> {
  String _selectedSortOption = 'Name';
  TextEditingController _locationController = TextEditingController();

  // Sample doctor data (replace with real data)
  List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. John Doe",
      "location": "Cape Town",
      "fees": "R500",
      "scans": ["X-ray", "MRI", "CT Scan"],
      "bio": "Expert in diagnostic radiology with 10+ years of experience.",
      "profilePic": null,
      "verified": true,
    },
    {
      "name": "Dr. Jane Smith",
      "location": "Johannesburg",
      "fees": "R700",
      "scans": ["Ultrasound", "X-ray"],
      "bio": "Specializes in women's health and radiology.",
      "profilePic": null,
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4567b7),
                Color(0xFF66d9ef)
              ], // Care Blue to Soothing Blue gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Find a Doctor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFf7f7f7), // Soft Gray Background
        child: Column(
          children: [
            // Enhanced Search bar with gradient border
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Location",
                        prefixIcon: const Icon(Icons.location_on,
                            color: Color(0xFF4567b7)), // Care Blue
                        suffixIcon: _locationController.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _locationController.clear();
                                  });
                                },
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF66d9ef), // Soothing Blue Border
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8bc34a), // Connect Green Border
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Redraw for suffix icon update
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _selectedSortOption,
                    items: ['Name', 'Fees', 'Location']
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSortOption = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Scrollable list of doctors
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to detailed doctor profile
                    },
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.grey.withOpacity(0.4),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Doctor profile picture
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: doctor["profilePic"] != null
                                  ? NetworkImage(doctor["profilePic"])
                                  : null,
                              child: doctor["profilePic"] == null
                                  ? const Icon(Icons.person,
                                      size: 30, color: Colors.grey)
                                  : null,
                            ),
                            const SizedBox(width: 16),

                            // Doctor details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor["name"],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4567b7), // Care Blue
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor["location"],
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 6),
                                  Wrap(
                                    spacing: 8.0,
                                    children: doctor["scans"]
                                        .map<Widget>((scan) => Chip(
                                              label: Text(scan),
                                              backgroundColor: const Color(
                                                  0xFF66d9ef), // Soothing Blue
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Fees: ${doctor["fees"]}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    doctor["bio"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Verified status
                            Column(
                              children: [
                                doctor["verified"]
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : const Icon(Icons.cancel,
                                        color: Colors.red),
                                const SizedBox(height: 4),
                                Text(
                                  doctor["verified"]
                                      ? "Verified"
                                      : "Not Verified",
                                  style: TextStyle(
                                    color: doctor["verified"]
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation
        },
        selectedItemColor: const Color(0xFF8bc34a), // Connect Green
        unselectedItemColor:
            Colors.grey[600], // Softened color for unselected items
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
