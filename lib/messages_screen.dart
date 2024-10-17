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
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4567b7),
                Color(0xFF66d9ef)
              ], // Care Blue to Soothing Blue
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Messages",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Conversation List on the left
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
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      conversation["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(conversation["lastMessage"]),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(conversation["time"],
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          child: const Text(
                            "2",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle switching to the message thread
                    },
                  );
                },
              ),
            ),
          ),

          // Message Thread on the right
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message['isMe'];

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isMe ? 15 : 0),
                              topRight: Radius.circular(isMe ? 0 : 15),
                              bottomLeft: const Radius.circular(15),
                              bottomRight: const Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['message'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                message['time'],
                                style: TextStyle(
                                  color: isMe ? Colors.white70 : Colors.black54,
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

                // Message Input
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
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
