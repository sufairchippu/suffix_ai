import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';
class LogoutUsecase {
  final AuthRepo repo;
  LogoutUsecase(this.repo);
  Future<void> call() {
    return repo.logout();
  }
}
