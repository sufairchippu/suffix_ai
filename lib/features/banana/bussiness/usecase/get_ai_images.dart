import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/entities/image_entity.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoredAiImages {
  final SupabaseRepository repo;
  GetStoredAiImages(this.repo);
  Future<Either<Failure, List<UserImageEntity>>> call() async {
    return repo.getImages();
  }
}
