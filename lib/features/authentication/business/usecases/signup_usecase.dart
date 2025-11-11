import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';

class SignupUsecase {
  final AuthRepo repo;
  SignupUsecase(this.repo);

  Future<UserEntity?> call(String email, String password) {
    return repo.signup(email, password);
  }
}
