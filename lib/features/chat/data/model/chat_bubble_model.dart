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
    'msgtype': msgtype.name,
    'attachment': attachment == null
        ? null
        : jsonEncode(attachment!.map((e) => e.toMap()).toList()),
  };

  factory ChatBubbleModel.fromMap(Map<String, dynamic> map) {
    final rawAttachment = map['attachment'];
    List<Attachment>? parsedAttachments;

    if (rawAttachment != null &&
        rawAttachment is String &&
        rawAttachment.isNotEmpty) {
      final decoded = jsonDecode(rawAttachment) as List;
      parsedAttachments = decoded.map((e) => Attachment.fromMap(e)).toList();
    }
    return ChatBubbleModel(
      id: map['id'],
      message: map['message'],
      time: map['time'],
      msgtype: map['msgtype'] == 'ai' ? MessegeOwner.ai : MessegeOwner.user,
      attachment: parsedAttachments,

      chatSetID: map['chat_set_id'],
    );
  }
}
