import 'dart:developer';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/model/chat_bubble_model.dart';
import 'package:dartz/dartz.dart';

class ChatBubbleRepoImpl implements ChatBubbleRepository {
  final ChatLocalDataSource localchat;
  ChatBubbleRepoImpl(this.localchat);
  @override
  Future<void> addChat(Chatbubble chat) async {
    final data = ChatBubbleModel(
      message: chat.message,
      time: chat.time,
 
      msgtype: chat.msgtype,
      attachment: chat.attachment,
    );

    log('message.  has insertted db');
    localchat.insertChat(data);
    

// final dataaaaaa= localchat.getSinglChat(int.parse(data.id!));
  }

  @override
  Future<void> deleteChat(int index) async {
    localchat.deleteChat(index);
  }

  @override
  Future<Either<Failure, List<Chatbubble>>> getChats() async {
    try {
      final getdata = await localchat.getAllChats();

      return right(getdata.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<void> clearChats() async {
    localchat.clearAllChats();
  }
}
