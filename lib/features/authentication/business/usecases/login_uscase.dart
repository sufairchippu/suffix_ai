import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';

class LoginUscase {
  final AuthRepo repo;
  LoginUscase(this.repo);
  Future<UserEntity?> call(String email, String password) {
    return repo.login(email, password);
  }
}
