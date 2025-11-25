import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_set_model.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/remote_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/model/chat_bubble_model.dart';
import 'package:dartz/dartz.dart';

class SupabaseRepoImpl extends SupabaseRepository {
  final RemoteDataSource supaDataSource;
  SupabaseRepoImpl(this.supaDataSource);
  @override
  Future<void> addSingleChatRemote(Chatbubble chat) {
    final ChatBubbleModel chatmodel = ChatBubbleModel(
      message: chat.message,
      time: chat.time,
      msgtype: chat.msgtype,
      chatSetID: chat.chatSetID,
      attachment: chat.attachment,
    );
    return supaDataSource.inserttoRemote(chatmodel);
  }

  @override
  Future<void> clearWholeChats() async {
    supaDataSource.clearWholeData();
  }

  @override
  Future<void> deleteChatRemote(String chatSetID) async {
    supaDataSource.deleteChat(chatSetID);
  }

  @override
  Future<Either<Failure, List<Chatbubble>>> getChatRemote(
    String chatSetID,
  ) async {
    try {
      final getchts = await supaDataSource.getchats(chatSetID);
      return right(getchts.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatSetModel>>> getChatSETRemote() async {
    try {
      final chatset = await supaDataSource.getWholeChatsets();
      return right(chatset);
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }
}
