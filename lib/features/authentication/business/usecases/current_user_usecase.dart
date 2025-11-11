import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';

class CurrentUserUsecase {
  final AuthRepo repo;
  CurrentUserUsecase(this.repo);
  UserEntity? call() {
    return repo.currentUser();
  }
}
