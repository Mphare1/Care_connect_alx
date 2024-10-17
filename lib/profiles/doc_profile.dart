import 'package:care_connect/home_patience.dart';
import 'package:care_connect/messages_screen.dart';
import 'package:flutter/material.dart';

class DocProfiles extends StatefulWidget {
  const DocProfiles({super.key});

  @override
  State<DocProfiles> createState() => _DocProfilesState();
}

class _DocProfilesState extends State<DocProfiles> {
  String _selectedSortOption = 'Name';
  TextEditingController _locationController = TextEditingController();

  // Sample doctor data with ratings (replace with real data)
  List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. John Doe",
      "location": "Cape Town",
      "fees": "R500",
      "scans": ["X-ray", "MRI", "CT Scan"],
      "bio": "Expert in diagnostic radiology with 10+ years of experience.",
      "profilePic": null,
      "verified": true,
      "rating": 4.5, // New field for rating
    },
    {
      "name": "Dr. Jane Smith",
      "location": "Johannesburg",
      "fees": "R700",
      "scans": ["Ultrasound", "X-ray"],
      "bio": "Specializes in women's health and radiology.",
      "profilePic": null,
      "verified": false,
      "rating": 3.0, // New field for rating
    },
  ];

  List<Map<String, dynamic>> sortedDoctors() {
    List<Map<String, dynamic>> sortedList = List.from(doctors);

    if (_selectedSortOption == 'Name') {
      sortedList.sort((a, b) => a['name'].compareTo(b['name']));
    } else if (_selectedSortOption == 'Fees') {
      sortedList.sort((a, b) =>
          int.parse(a['fees'].replaceAll(RegExp(r'[^0-9]'), '')) -
          int.parse(b['fees'].replaceAll(RegExp(r'[^0-9]'), '')));
    } else if (_selectedSortOption == 'Location') {
      sortedList.sort((a, b) => a['location'].compareTo(b['location']));
    }

    return sortedList;
  }

  // Method to build star rating
  Widget buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }

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
            onPressed: () {
              setState(() {
                // Refresh the list or perform any needed action
              });
            },
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
                              color: Color(0xFF66d9ef),
                              width: 2), // Soothing Blue Border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF8bc34a),
                              width: 2), // Connect Green Border
                        ),
                      ),
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
                itemCount: sortedDoctors().length,
                itemBuilder: (context, index) {
                  final doctor = sortedDoctors()[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to detailed doctor profile (implement navigation here)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DoctorDetailPage(doctor: doctor),
                        ),
                      );
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
                                  buildStarRating(
                                      doctor["rating"]), // Star rating widget
                                  const SizedBox(height: 10),
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
          switch (index) {
            case 0:
              // Navigate to Home screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              // Navigate to Messages screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MessagingScreen()),
              );
              break;
            case 2:
              // Navigate to Profile screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
            default:
              break;
          }
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

// Example HomeScreen, MessagesScreen, and ProfileScreen

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: Center(child: Text('Messages Screen')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Screen')),
    );
  }
}

// Example of a Doctor Detail Page
class DoctorDetailPage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location: ${doctor['location']}"),
            Text("Fees: ${doctor['fees']}"),
            Text("Bio: ${doctor['bio']}"),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
