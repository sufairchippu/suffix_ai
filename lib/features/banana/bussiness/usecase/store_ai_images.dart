import 'dart:typed_data';

import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';

class StoreAiImages {
  final SupabaseRepository repo;
  StoreAiImages(this.repo);
  Future<void> call(Uint8List imageByte) {
    return repo.addImmage(imageByte);
  }
}
