import 'dart:convert';

import '../../business/entities/chat_bubble.dart';

class ChatBubbleModel extends Chatbubble {
  ChatBubbleModel({
    required super.message,
    required super.time,
    super.id,
    required super.msgtype,
    super.attachment,
    required super.chatSetID,
  });

  factory ChatBubbleModel.fromEntity(Chatbubble chat) => ChatBubbleModel(
    chatSetID: chat.chatSetID,
    message: chat.message,
    time: chat.time,
    id: chat.id,
    msgtype: chat.msgtype,
    attachment: chat.attachment,
  );
  Chatbubble toEntity() => Chatbubble(
    chatSetID: chatSetID,
    message: message,
    time: time,
    id: id,
    msgtype: msgtype,
    attachment: attachment,
  );
  Map<String, dynamic> toMap() => {
    'chat_set_id': chatSetID,
    'id': id,
    'message': message,
    'time': time,
    'msgtype': msgtype.index,
    'attachment': attachment != null
        ? jsonEncode(attachment!.map((e) => e.toMap()).toList())
        : null,
  };

  factory ChatBubbleModel.fromMap(Map<String, dynamic> map) => ChatBubbleModel(
    id: map['id'],
    message: map['message'],
    time: map['time'],
    msgtype: MessegeOwner.values[map['msgtype']],
    attachment: map['attachment'] != null
        ? (jsonDecode(map['attachment']) as List)
              .map((e) => Attachment.fromMap(e))
              .toList()
        : null,
    chatSetID: map['chat_set_id'],
  );
}
