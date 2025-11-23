import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';

class UpdatePassUscase {
  final AuthRepo repo;
  UpdatePassUscase(this.repo);
  Future<void> call(String newPassword){
    return repo.updatePassword(newPassword);
  }
}