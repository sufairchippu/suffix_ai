import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_set_model.dart';
import 'package:dartz/dartz.dart';

abstract class SupabaseRepository {
  // Future<Either<Failure, List<Chatbubble>>> getChats();

  Future<void> addSingleChatRemote(Chatbubble chat);
  Future<void> deleteChatRemote(String chatSetID);
  Future<Either<Failure, List<Chatbubble>>> getChatRemote(String chatSetID);
  Future<Either<Failure, List<ChatSetModel>>> getChatSETRemote();

  Future<void> clearWholeChats();

}
