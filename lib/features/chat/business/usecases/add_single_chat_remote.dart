import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';

class AddSingleChatRemote {
  final SupabaseRepository repo;
  AddSingleChatRemote(this.repo);
  Future<void> call(Chatbubble chat) {
    return repo.addSingleChatRemote(chat);
  }
}
