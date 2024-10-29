import 'dart:async';
import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final String patientName;
  final String appointmentType;
  final DateTime appointmentDateTime;
  final String notes;
  final String? profileImageUrl;

  const AppointmentDetailsScreen({
    Key? key,
    required this.patientName,
    required this.appointmentType,
    required this.appointmentDateTime,
    required this.notes,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  _AppointmentDetailsScreenState createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  bool _isExpanded = false;
  Duration _countdownDuration = Duration.zero;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _updateCountdown();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    setState(() {
      _countdownDuration = widget.appointmentDateTime.difference(now);
      if (_countdownDuration.isNegative) {
        _countdownDuration = Duration.zero;
        _countdownTimer
            ?.cancel(); // Stop the timer when the countdown reaches zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
        backgroundColor: const Color(0xFF4567b7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 16),
            _buildCountdownTimer(),
            const SizedBox(height: 16),
            _buildSectionTitle("Appointment Details"),
            _buildCardSection(
                Icons.event, "Appointment Type", widget.appointmentType),
            const SizedBox(height: 16),
            _buildCardSection(Icons.access_time, "Time",
                widget.appointmentDateTime.toString()),
            const SizedBox(height: 16),
            _buildSectionTitle("Notes"),
            _buildExpandableNotes(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: widget.profileImageUrl != null
              ? NetworkImage(widget.profileImageUrl!)
              : AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        const SizedBox(width: 16),
        Text(
          widget.patientName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownTimer() {
    String countdownText = "${_countdownDuration.inDays}d "
        "${_countdownDuration.inHours % 24}h "
        "${_countdownDuration.inMinutes % 60}m "
        "${_countdownDuration.inSeconds % 60}s";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time until Appointment:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          countdownText,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCardSection(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4567b7), size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableNotes() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isExpanded
                  ? widget.notes
                  : (widget.notes.length > 50
                      ? widget.notes.substring(0, 50) + '...'
                      : widget.notes),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isExpanded ? "Show Less" : "Read More",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF4567b7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Handle reschedule action
          },
          icon: Icon(Icons.edit_calendar),
          label: Text("Reschedule"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8bc34a),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Handle cancel action
          },
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFf44336),
          ),
        ),
      ],
    );
  }
}
