import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Dummy data for conversations
  List<Map<String, dynamic>> conversations = [
    {
      "name": "Dr. John Doe",
      "lastMessage": "Please bring your X-ray results tomorrow.",
      "time": "14:35",
      "profilePic": null,
    },
    {
      "name": "Dr. Jane Smith",
      "lastMessage": "Your appointment is scheduled for next week.",
      "time": "12:20",
      "profilePic": null,
    },
  ];

  // Dummy data for message thread
  List<Map<String, dynamic>> messages = [
    {
      "sender": "Me",
      "message": "Hi, Dr. Doe, can I get the results today?",
      "time": "14:20",
      "isMe": true,
    },
    {
      "sender": "Dr. John Doe",
      "message": "Sure, I'll send them shortly.",
      "time": "14:22",
      "isMe": false,
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
        title: const Text("Messages",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Conversation List
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFf7f7f7), // Soft Gray background
              child: ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conversation = conversations[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF4567b7),
                      child: conversation["profilePic"] == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                    title: Text(
                      conversation["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(conversation["lastMessage"]),
                    trailing: Text(conversation["time"]),
                    onTap: () {
                      // Handle switching to the message thread
                    },
                  );
                },
              ),
            ),
          ),

          // Message Thread
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message['isMe']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: message['isMe']
                                ? const Color(0xFF4567b7)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['message'],
                                style: TextStyle(
                                  color: message['isMe']
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                message['time'],
                                style: TextStyle(
                                  color: message['isMe']
                                      ? Colors.white70
                                      : Colors.black54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Message input
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF66d9ef),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              setState(() {
                                messages.add({
                                  "sender": "Me",
                                  "message": _messageController.text,
                                  "time": "Now",
                                  "isMe": true,
                                });
                                _messageController.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
