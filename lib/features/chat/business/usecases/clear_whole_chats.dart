import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';

class ClearWholeChats {
  final SupabaseRepository repo;
  ClearWholeChats(this.repo);
  Future<void> call() {
    return repo.clearWholeChats();
  }
}
