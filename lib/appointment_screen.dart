import 'package:care_connect/profiles/doc_profile.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  // Dummy data for upcoming and previous appointments
  final List<Map<String, dynamic>> upcomingAppointments = [
    {'date': DateTime.now().add(Duration(days: 3)), 'doctor': 'Dr. Smith'},
    {'date': DateTime.now().add(Duration(days: 10)), 'doctor': 'Dr. Adams'},
  ];

  final List<Map<String, dynamic>> previousAppointments = [
    {
      'date': DateTime.now().subtract(Duration(days: 30)),
      'doctor': 'Dr. Clark'
    },
    {
      'date': DateTime.now().subtract(Duration(days: 60)),
      'doctor': 'Dr. Patel'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4567b7), Color(0xFF66d9ef)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "My Appointments",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildUserProfileSummary(),
              const SizedBox(height: 20),
              _buildCountdown(),
              const SizedBox(height: 20),
              _buildAppointmentFilters(),
              const SizedBox(height: 20),
              _buildAppointmentSection(context), // Pass context here
              const SizedBox(height: 20),
              _buildDoctorSuggestion(),
              const SizedBox(height: 20),
              _buildNotesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7), // Soft Gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage('https://example.com/user-profile.jpg'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, John Doe",
                style: TextStyle(
                  color: const Color(0xff4567b7), // Care Blue
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Take control of your health today!",
                style: TextStyle(
                  color: const Color(0xff666666), // Dark Gray
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    if (upcomingAppointments.isNotEmpty) {
      final nextAppointment = upcomingAppointments.first['date'];
      final difference = nextAppointment.difference(DateTime.now()).inDays;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xfff7f7f7), // Soft Gray
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule,
                color: const Color(0xff8bc34a)), // Connect Green
            const SizedBox(width: 10),
            Text(
              "Your next appointment is in $difference days",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xff4567b7), // Care Blue
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink(); // Empty if no upcoming appointments
  }

  Widget _buildAppointmentFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChip(
          label: const Text('Upcoming'),
          selected: true,
          onSelected: (bool value) {
            // Logic to show only upcoming appointments
          },
        ),
        const SizedBox(width: 10),
        FilterChip(
          label: const Text('Previous'),
          selected: false,
          onSelected: (bool value) {
            // Logic to show only previous appointments
          },
        ),
      ],
    );
  }

  Widget _buildAppointmentSection(BuildContext context) {
    if (upcomingAppointments.isEmpty) {
      return Column(
        children: [
          const Text(
            "You have no upcoming appointments.",
            style: TextStyle(color: Color(0xff666666), fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocProfiles()), // Navigation fixed
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8bc34a), // Connect Green
            ),
            child: const Text("Schedule an Appointment"),
          ),
        ],
      );
    } else {
      return Column(
        children: upcomingAppointments.map((appointment) {
          return ListTile(
            title: Text("Appointment with ${appointment['doctor']}"),
            subtitle: Text("Scheduled for ${appointment['date']}"),
            trailing: Icon(Icons.arrow_forward, color: const Color(0xff8bc34a)),
          );
        }).toList(),
      );
    }
  }

  Widget _buildDoctorSuggestion() {
    if (previousAppointments.isNotEmpty) {
      final lastDoctor = previousAppointments.last['doctor'];

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xfff7f7f7), // Soft Gray
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              "Would you like to book another appointment with $lastDoctor?",
              style: TextStyle(
                color: const Color(0xff4567b7), // Care Blue
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to doctor booking
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8bc34a), // Connect Green
              ),
              child: Text(
                "Book with $lastDoctor",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7), // Soft Gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes from your previous appointments",
            style: TextStyle(
              color: const Color(0xff4567b7), // Care Blue
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: Text("Appointment with Dr. Patel"),
            subtitle: Text("Take medication twice daily."),
          ),
          ListTile(
            title: Text("Appointment with Dr. Clark"),
            subtitle: Text("Follow-up in one month."),
          ),
        ],
      ),
    );
  }
}
