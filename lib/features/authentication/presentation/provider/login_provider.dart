import 'dart:developer';
import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/business/repo/auth_repo.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/current_user_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/login_uscase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/logout_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/send_email_uscase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/signup_usecase.dart';
import 'package:clean_architutre_learn/features/authentication/business/usecases/update_pass_uscase.dart';
import 'package:clean_architutre_learn/features/authentication/data/data_sources/auth_data_souurce.dart';
import 'package:clean_architutre_learn/features/authentication/data/repo/auth_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
final sendMailProvider = Provider(
  (ref) => SendEmailUscase(ref.read(authRepoProvider)),
);
final restPassProvider = Provider(
  (ref) => UpdatePassUscase(ref.read(authRepoProvider)),
);
final logoutUserProvider = Provider(
  (ref) => LogoutUsecase(ref.read(authRepoProvider)),
);
final signupUserProvider = Provider(
  (ref) => SignupUsecase(ref.read(authRepoProvider)),
);

final authErrorProvider = StateProvider<String>((ref) => '');

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
  late final SendEmailUscase _sendemailLink;
  late final UpdatePassUscase _updatePass;

  @override
  Future<UserEntity?> build() async {
    _getUser = ref.read(getUserProvider);
    _login = ref.read(loginUserProvider);
    _logout = ref.read(logoutUserProvider);
    _signup = ref.read(signupUserProvider);
    _sendemailLink = ref.read(sendMailProvider);
    _updatePass = ref.read(restPassProvider);
    return _getUser.call();
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
      final user = _getUser();
      state = AsyncData(user);
      ref.read(authErrorProvider.notifier).state =
          '${user!.email} has logged in';
    } on AuthApiException catch (e) {
      ref.read(authErrorProvider.notifier).state = e.message;
    } catch (e, st) {
      state = AsyncError(e, st);
      ref.read(authErrorProvider.notifier).state = 'User not logged in!,';
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    // ref.read(authErrorProvider.notifier).state = null;
    try {
      final user = await _login(email, password);
      if (user == null) {
        ref.read(authErrorProvider.notifier).state =
            "Somrthing Went wrong,cant find the user";
        throw AuthApiException('Invalid login attempt');
      } else {
        state = AsyncData(user);
        // ref.read(authErrorProvider.notifier).state = null;
        ref.read(authErrorProvider.notifier).state =
            '${user.email} has  logged in';
      }
    } on AuthApiException catch (e) {
      log('Supabase Auth Error: $e');
      // ref.read(authErrorProvider.notifier).state =
      //     CoreConstants.mapSupabaseError(e);
      ref.read(authErrorProvider.notifier).state = e.message;
      log('$e.   api exception');
      state = AsyncError(e, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
      log('where showing it  $e.   api exception');
    }
  }

  Future<void> signup(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _signup(email, password);
      state = AsyncData(user);
      ref.read(authErrorProvider.notifier).state =
          '${user!.email} has  registered & logged in';
    } on AuthApiException catch (e) {
      ref.read(authErrorProvider.notifier).state = e.message;
      throw Exception('Login failed :$e');
    } catch (e, st) {
      state = AsyncError(e, st);

      log('$e------------------------------------------------');
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _logout();
      state = const AsyncData(null);
      // ref.read(authErrorProvider.notifier).state =
      //     'User has Logout sucessfully! ';
    } on AuthApiException catch (e) {
      ref.read(authErrorProvider.notifier).state = e.message;
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> sendemailLink(String email) async {
    state = const AsyncLoading();
    try {
      await _sendemailLink(email);
      state = const AsyncData(null);
      ref.read(authErrorProvider.notifier).state =
          'Sended mail to the email registered ';
    } on AuthApiException catch (e) {
      ref.read(authErrorProvider.notifier).state = e.message;
      throw Exception('link failed to send :$e');
    } catch (e, st) {
      state = AsyncError(e, st);

      log('$e------------------------------------------------');
    }
  }

  Future<void> newPaaword(String newPass) async {
    state = const AsyncLoading();
    try {
      await _updatePass(newPass);
      state = const AsyncData(null);
      ref.read(authErrorProvider.notifier).state = 'Password changed ';
    } on AuthApiException catch (e) {
      ref.read(authErrorProvider.notifier).state = e.message;
      throw Exception('Failed to reset password :$e');
    } catch (e, st) {
      state = AsyncError(e, st);

      log('$e------------------------------------------------');
    }
  }
  
}
