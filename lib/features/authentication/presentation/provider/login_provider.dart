import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/current_user_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/login_uscase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/logout_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/signup_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/data/data_sources/auth_data_souurce.dart';
import 'package:clean_architutre_learn/features/authentication/data/repo/auth_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPasswordProvider = StateProvider<bool>((ref) {
  return true;
});
final loginConformPasswordProvider = StateProvider<bool>((ref) {
  return true;
});
final loginMethodeProvider = StateProvider<bool>((ref) {
  return false;
});

final authDataSourceProvider = Provider<AuthDataSouurce>(
  (ref) => AuthDataSouurceImpl(),
);

final getUserProvider = Provider(
  (ref) => CurrentUserUsecase(ref.read(authRepoProvider)),
);
final loginUserProvider = Provider(
  (ref) => LoginUscase(ref.read(authRepoProvider)),
);
final logoutUserProvider = Provider(
  (ref) => LogoutUsecase(ref.read(authRepoProvider)),
);
final signupUserProvider = Provider(
  (ref) => SignupUsecase(ref.read(authRepoProvider)),
);

final authRepoProvider = Provider<AuthRepo>((ref) {
  final dataSource = ref.read(authDataSourceProvider);
  return AuthRepoImpl(dataSource);
});

final authNotifierProvider =
    AsyncNotifierProvider<AuthProviderNotifier, UserEntity?>(
      AuthProviderNotifier.new,
    );

class AuthProviderNotifier extends AsyncNotifier<UserEntity?> {
  late final CurrentUserUsecase _getUser;
  late final LoginUscase _login;
  late final SignupUsecase _signup;
  late final LogoutUsecase _logout;
  @override
  Future<UserEntity?> build() async {
    _getUser = ref.read(getUserProvider);
    _login = ref.read(loginUserProvider);
    _logout = ref.read(logoutUserProvider);
    _signup = ref.read(signupUserProvider);
    return  _getUser.call();
  }
//  Future<void> _getUser() async {
//     state = const AsyncLoading();
//     try {
//        _getUser();
//       state = const AsyncData(null);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
  // ✅ helper method for manual reload
  Future<void> currentUser() async {
    state = const AsyncLoading();
    try {
      final user = await _getUser();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _login(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signup(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _signup(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _logout();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
