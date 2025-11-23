import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_set_model.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatSetRemote {
  final SupabaseRepository repo;
  GetChatSetRemote(this.repo);
  Future<Either<Failure, List<ChatSetModel>>> call() {
    return repo.getChatSETRemote();
  }
}
