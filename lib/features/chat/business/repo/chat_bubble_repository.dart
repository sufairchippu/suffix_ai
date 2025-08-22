import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:dartz/dartz.dart';

abstract class ChatBubbleRepository {
  Future<Either<Failure, List<Chatbubble>>> getChats();
  Future<void> addChat(Chatbubble chat);
  Future<void> deleteChat(int index);
  Future<void> clearChats();

}
