import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/controller/chat_controller.dart';
import 'package:intl/intl.dart';

class ChatFragment extends StatelessWidget {
  const ChatFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: chatController.fetchMessages, // Call the refresh function when pressed
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  final isSender = message.isSender;
                  final messageColor = isSender ? Colors.blueAccent : Colors.grey[300];
                  final textColor = isSender ? Colors.white : Colors.black;

                  return Align(
                    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: messageColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.message,
                            style: TextStyle(
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            DateFormat('hh:mm a').format(message.createdAt), // Format time
                            style: TextStyle(
                              color: textColor.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatController.messageController,
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
                  onPressed: chatController.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
