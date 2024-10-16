import 'package:care_connect/profiles/doc_profile.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<String> previousAppointments = [
    "Dr. Smith - Checkup on 2024-10-01",
    "Dr. Jones - Follow-up on 2024-09-20",
    "Dr. Brown - Consultation on 2024-08-15",
  ];

  List<Map<String, dynamic>> upcomingAppointments = [
    // {"doctor": "Dr. Green", "date": DateTime(2024, 10, 15)},
    // {"doctor": "Dr. Blue", "date": DateTime(2024, 10, 20)},
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
              _buildCalendar(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildAppointmentSection(),
              const SizedBox(height: 20),
              _buildSectionTitle("Previous Appointments"),
              ...previousAppointments
                  .map((appointment) => _buildAppointmentCard(appointment)),
              const SizedBox(height: 20),
              _buildNotesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7), // Soft Gray
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: const Color(0xff8bc34a), // Connect Green
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: const Color(0xff66d9ef), // Soothing Blue
            shape: BoxShape.circle,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, events) {
            bool isHighlighted = upcomingAppointments
                .any((appointment) => isSameDay(date, appointment['date']));

            bool isWeekend = date.weekday == DateTime.saturday ||
                date.weekday == DateTime.sunday;

            return Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isHighlighted)
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xff66d9ef), // Highlight color
                      ),
                    ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isWeekend
                          ? Colors.red
                          : const Color(
                              0xff000000), // Red for weekend digits, Black for others
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search appointments...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentSection() {
    if (upcomingAppointments.isEmpty) {
      return _buildNoAppointments();
    } else {
      return Column(
        children: [
          _buildSectionTitle("Upcoming Appointments"),
          ...upcomingAppointments.map((appointment) => _buildAppointmentCard(
              "${appointment['doctor']} - Appointment on ${appointment['date'].toLocal()}")),
        ],
      );
    }
  }

  Widget _buildNoAppointments() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7), // Soft Gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "You currently have no upcoming appointments.",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff000000), // Black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Schedule your appointment to start managing your health!",
            style: TextStyle(color: Color(0xff666666)), // Dark Gray
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocProfiles(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8bc34a), // Connect Green
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: const Text(
              "Schedule Appointment",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xff4567b7), // Care Blue
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(String appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          appointment,
          style: const TextStyle(color: Color(0xff000000)), // Black
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff7f7f7), // Soft Gray
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Notes from Previous Appointments"),
          Text(
            "1. Remember to follow up on test results.\n"
            "2. Discuss medication changes during next visit.\n"
            "3. Schedule next appointment for 2024-11-10.",
            style: const TextStyle(color: Color(0xff000000)), // Black
          ),
        ],
      ),
    );
  }
}
