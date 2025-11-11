import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> signup(String email, String password);
  Future<void> logout();
UserEntity? currentUser();

}
