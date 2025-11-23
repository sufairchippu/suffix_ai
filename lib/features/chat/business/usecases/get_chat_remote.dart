import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatRemote {
  final SupabaseRepository repo;
  GetChatRemote(this.repo);
  Future<Either<Failure, List<Chatbubble>>> call(String chatSetID) {
    return repo.getChatRemote(chatSetID);
  }
}
