import 'package:flutter/material.dart';

class ChatFragment extends StatefulWidget {
  const ChatFragment({super.key});

  @override
  State<ChatFragment> createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  final List<Map<String, dynamic>> _messages = []; // List to hold chat messages
  final TextEditingController _messageController = TextEditingController();
  bool _isSender = true; // Flag to toggle between sender and receiver for demo purposes

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': message,
          'isSender': _isSender,
        });
        _messageController.clear();
        _isSender = !_isSender; // Toggle between sender and receiver
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // To display the most recent message at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSender = message['isSender'];
                return Align(
                  alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSender ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: isSender ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
