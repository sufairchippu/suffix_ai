import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';
import 'package:clean_architutre_learn/features/authentication/data/data_sources/auth_data_souurce.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSouurce datatSourece;
  AuthRepoImpl(this.datatSourece);
  @override
  Future<UserEntity?> login(String email, String password) =>
      datatSourece.login(email, password);

  @override
  Future<void> logout() => datatSourece.logout();

  @override
  Future<UserEntity?> signup(String email, String password) =>
      datatSourece.signup(email, password);

  @override
  UserEntity? currentUser() => datatSourece.currentUser();

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      datatSourece.sendPasswordResetEmail(email);

  @override
  Future<void> updatePassword(String newPassword) =>
      datatSourece.updatePassword(newPassword);
}
