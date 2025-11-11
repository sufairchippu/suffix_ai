import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';
import 'package:clean_architutre_learn/features/authentication/data/data_sources/auth_data_souurce.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSouurce dtatSourece;
  AuthRepoImpl(this.dtatSourece);
  @override
  Future<UserEntity?> login(String email, String password) =>
      dtatSourece.login(email, password);

  @override
  Future<void> logout() => dtatSourece.logout();

  @override
  Future<UserEntity?> signup(String email, String password) =>
      dtatSourece.signup(email, password);

  @override
  UserEntity? currentUser() => dtatSourece.currentUser();
}
