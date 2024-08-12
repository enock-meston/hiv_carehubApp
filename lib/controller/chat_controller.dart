import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:hiv_carehub/model/message_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  var messages = <ChatMessageModel>[].obs;
  final TextEditingController messageController = TextEditingController();

  // URL for the API endpoint

  final String apiUrl = API.Messages;
  final String apiUrlStore = API.StoreMessage;

  @override
  void onInit() {
    fetchMessages();
    super.onInit();
  }

  void fetchMessages() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? id = sharedPreferences.getInt('id');

    if (id == null) {
      Get.snackbar('Error', 'No user ID found');
      return;
    }

    if (apiUrl == null || apiUrl.isEmpty) {
      Get.snackbar('Error', 'API URL is not set');
      return;
    }

    try {
      final response = await http.get(Uri.parse('$apiUrl$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] is List) {
          final List<dynamic> messagesData = jsonResponse['data'];
          messages.value = messagesData.map((msg) => ChatMessageModel.fromJson(msg)).toList();
        } else {
          Get.snackbar('Error', 'Unexpected JSON structure');
        }
      } else {
        Get.snackbar('Error', 'Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
      Get.snackbar('Error', 'Failed to load messages: $e');
    }
  }



  void sendMessage() async {
    final message = messageController.text;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? id = sharedPreferences.getInt('id');

    if (message.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(apiUrlStore),
          body: json.encode({
            'message': message,
            'sender_id': id.toString(),
          }),
          headers: {'Content-Type': 'application/json'}, // Correct Content-Type
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}'); // Print raw response

        final responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          print('Success: ${responseData}');
          if (responseData['status'] == "success") { // Check for success status
            messageController.clear();
            Get.snackbar('Message', 'message Sent');
          } else {
            print('Server error: ${responseData}');
            Get.snackbar('Server error', 'Server error: ${responseData}');
          }
        } else {
          print('Failed to send message: ${responseData}');
          Get.snackbar('Error', 'Failed to send message: ${responseData}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to send message');
        print('Error: ${e}');
      }
    }
  }

}
