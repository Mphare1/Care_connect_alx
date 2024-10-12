import 'package:flutter/material.dart';

class DocProfiles extends StatefulWidget {
  const DocProfiles({super.key});

  @override
  State<DocProfiles> createState() => _DocProfilesState();
}

class _DocProfilesState extends State<DocProfiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Find a doctor",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Location",
                    ),
                  ),
                ),
                const SizedBox(
                    width: 8), // Add space between the TextField and Text
                const Text("Sort by")
              ],
            ),
            // Add more children here as needed
          ],
        ));
  }
}
