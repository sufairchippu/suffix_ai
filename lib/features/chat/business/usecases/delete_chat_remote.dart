import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';

class DeleteChatRemote {
  final SupabaseRepository repo;
  DeleteChatRemote(this.repo);
  Future<void> call(String chatSetID) {
    return repo.deleteChatRemote(chatSetID);
  }
}
