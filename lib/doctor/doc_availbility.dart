import 'package:flutter/material.dart';

class DoctorAvailabilityScreen extends StatefulWidget {
  const DoctorAvailabilityScreen({super.key});

  @override
  _DoctorAvailabilityScreenState createState() =>
      _DoctorAvailabilityScreenState();
}

class _DoctorAvailabilityScreenState extends State<DoctorAvailabilityScreen> {
  List<String> daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  Map<String, List<Map<String, TimeOfDay>>> availability =
      {}; // Store availability by day

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Availability"),
        backgroundColor: const Color(0xFF4567b7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Day Selection
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  final day = daysOfWeek[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        availability[day] ??= [];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: availability.containsKey(day)
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        day,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Availability slots
            availability.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: availability.keys.length,
                      itemBuilder: (context, index) {
                        final day = availability.keys.elementAt(index);
                        final slots = availability[day]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              day,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            // Display each slot for the day
                            ...slots.map((slot) => Card(
                                  child: ListTile(
                                    title: Text(
                                        "From: ${slot['start']!.format(context)} - To: ${slot['end']!.format(context)}"),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          slots.remove(slot);
                                          if (slots.isEmpty) {
                                            availability.remove(day);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                await _pickTimeSlot(context, day);
                              },
                              child: const Text("Add Time Slot"),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const Text(
                    "Select a day to add available time slots",
                    style: TextStyle(fontSize: 16),
                  ),
            const Spacer(),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Save availability logic here
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4567b7),
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTimeSlot(BuildContext context, String day) async {
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 12, minute: 0),
      );

      if (endTime != null) {
        setState(() {
          availability[day]!.add({"start": startTime, "end": endTime});
        });
      }
    }
  }
}
