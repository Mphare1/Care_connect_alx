import 'package:care_connect/doctor/doc_availbility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:care_connect/doctor/appointment_detail.dart';

class DoctorHomePage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> schedule = {
    "Mon": [
      {"time": "9:00 AM", "patient": "John Doe", "type": "Checkup"},
      {"time": "11:00 AM", "patient": "Sara Lee", "type": "Consultation"},
    ],
    "Tue": [
      {"time": "11:00 PM", "patient": "Alex Kim", "type": "Follow-up"},
      {"time": "1:00 PM", "patient": "Emily Watts", "type": "Consultation"},
    ],
    "Wed": [
      {"time": "10:00 AM", "patient": "Alex Kim", "type": "Follow-up"},
      {"time": "1:00 PM", "patient": "Emily Watts", "type": "Consultation"},
    ],
  };

  String getToday() {
    return DateFormat('E')
        .format(DateTime.now())
        .substring(0, 3); // e.g., "Mon"
  }

  DateTime convertStringToTime(String timeString, {DateTime? specificDate}) {
    // Trim the time string to remove leading/trailing whitespaces
    timeString = timeString.trim();

    // Create a DateFormat for the time string
    DateFormat format =
        DateFormat.jm(); // j for hour in am/pm format, m for minutes

    DateTime now = DateTime.now();

    try {
      // Parse the time
      DateTime parsedTime = format.parse(timeString);

      // If a specific date is provided, use it; otherwise, use today's date
      DateTime appointmentDate =
          specificDate ?? DateTime(now.year, now.month, now.day);

      return DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      print('Error parsing time: $e');
      // Handle error: return null or a default DateTime value if parsing fails
      return now; // You can choose to return now or throw an exception based on your needs
    }
  }

  @override
  Widget build(BuildContext context) {
    String today = getToday();
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text("Doctor Dashboard"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4567b7),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildSectionTitle("Today's Schedule"),
            _buildCard(
              child: Column(
                children: schedule[today]?.map<Widget>((appointment) {
                      return Column(
                        children: [
                          _scheduleItem(
                            context,
                            appointment["time"],
                            appointment["patient"],
                            appointment["type"],
                          ),
                          Divider(color: Colors.grey[300]),
                        ],
                      );
                    }).toList() ??
                    [const Text("No appointments for today.")],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Quick Actions"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _quickAction("New Consult", Icons.add_circle_outline),
                _quickAction("View Records", Icons.folder_open),
                _quickAction("Send Message", Icons.message),
                _quickAction("Set Availability", Icons.event, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorAvailabilityScreen(),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Notifications & Messages"),
            _buildCard(
              child: Column(
                children: [
                  _notificationItem("New message from John Doe", "9:30 AM"),
                  Divider(color: Colors.grey[300]),
                  _notificationItem(
                      "Appointment request from Sara Lee", "8:45 AM"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Today's Patients"),
            _buildCard(
              child: Column(
                children: [
                  _patientOverview(
                      "John Doe", "Checkup", "assets/images/patient1.jpg"),
                  Divider(color: Colors.grey[300]),
                  _patientOverview(
                      "Sara Lee", "Consultation", "assets/images/patient2.jpg"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Upcoming Appointments"),
            _buildCard(
              child: Column(
                children: [
                  _appointmentItem(
                      "Alex Kim", "Follow-up", "assets/images/patient3.jpg"),
                  Divider(color: Colors.grey[300]),
                  _appointmentItem("Emily Watts", "Consultation",
                      "assets/images/patient4.jpg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return _buildCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/doctor_profile.jpg'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Emily Carter",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Text(
                "Cardiologist - Available",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _scheduleItem(
      BuildContext context, String time, String patient, String type) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentDetailsScreen(
              patientName: patient,
              appointmentType: type,
              appointmentDateTime: convertStringToTime(time),
              notes: "Here are additional notes for this appointment.",
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Icon(Icons.schedule, color: Color(0xFF4567b7), size: 20),
            const SizedBox(width: 8),
            Text(
              time,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text("$patient - $type",
                    style: TextStyle(color: Colors.grey[600]))),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(String title, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF4567b7),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.black87, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _notificationItem(String text, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(Icons.notifications, color: Color(0xFF4567b7)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text, style: TextStyle(color: Colors.grey[600]))),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _patientOverview(String name, String status, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 10),
          Text(name, style: TextStyle(color: Colors.black87)),
          const Spacer(),
          Text(status, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _appointmentItem(String name, String type, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 10),
          Expanded(
              child: Text("$name - $type",
                  style: TextStyle(color: Colors.grey[600]))),
        ],
      ),
    );
  }
}
