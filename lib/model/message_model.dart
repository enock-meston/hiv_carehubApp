// models/chat_message.dart
class ChatMessageModel {
  final String message;
  final bool isSender;
  final bool isReceiver;
  final DateTime createdAt;

  ChatMessageModel({
    required this.message,
    required this.isSender,
    required this.isReceiver,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    // Extract data and handle possible null values
    return ChatMessageModel(
      message: json['message'] ?? '',
      isSender: json['sender_id'] == 2, // Adjust as necessary
      isReceiver: json['receiver_id'] == 1, // Adjust as necessary
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isSender': isSender,
      'receiver_id': isReceiver, // Changed to match field
      'created_at': createdAt.toIso8601String(),
    };
  }
}
