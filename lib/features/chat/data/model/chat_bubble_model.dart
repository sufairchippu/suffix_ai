import 'dart:convert';

import '../../business/entities/chat_bubble.dart';

class ChatBubbleModel {
  String message;
  String time;
  String id;
  MessegeOwner msgtype;
  List<String>? attachment;
  ChatBubbleModel({
    required this.message,
    required this.time,
    required this.id,
    required this.msgtype,
    this.attachment,
  });

  factory ChatBubbleModel.fromEntity(Chatbubble chat) => ChatBubbleModel(
    message: chat.message,
    time: chat.time,
    id: chat.id,
    msgtype: chat.msgtype,
    attachment: chat.attachment,
  );
  Chatbubble toEntity() => Chatbubble(
    message: message,
    time: time,
    id: id,
    msgtype: msgtype,
    attachment: attachment,
  );

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'time': time,
      'msgtype': msgtype.index, // store enum index
      'attachment': attachment != null ? jsonEncode(attachment) : null,
    };
  }

  // ✅ Convert from Map
  factory ChatBubbleModel.fromMap(Map<String, dynamic> map) {
    return ChatBubbleModel(
      id: map['id'],
      message: map['message'],
      time: map['time'],
      msgtype: MessegeOwner.values[map['msgtype']],
      attachment: map['attachment'] != null
          ? List<String>.from(jsonDecode(map['attachment']))
          : null,
    );
  }
}
