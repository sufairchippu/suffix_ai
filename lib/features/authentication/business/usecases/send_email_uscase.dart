import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';

class SendEmailUscase {
  final AuthRepo repo;
  SendEmailUscase(this.repo);
  Future<void> call(String email) {
    return repo.sendPasswordResetEmail(email);
  }
}
