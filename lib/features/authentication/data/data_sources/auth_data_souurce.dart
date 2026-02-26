import 'dart:async';
import 'dart:io';
import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSouurce {
  // final DioClientSuperBase client;
  // AuthDataSouurce();
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> signup(String email, String password);
  Future<void> logout();
  UserEntity? currentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updatePassword(String newPassword);
}
//  final response = await client.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );
//     final user=response.user;
//     if (user==null)return null;
//     return UserEntity(id: user.id, email: email);

class AuthDataSouurceImpl implements AuthDataSouurce {
  final SupabaseClient client = Supabase.instance.client;

  @override
  UserEntity? currentUser() {
    final user = client.auth.currentUser;
    if (user == null) return null;
    //store userdat in shared pref
    // LocalStorageService.
    return UserEntity(id: user.id, email: user.email ?? '');
  }

  @override
  Future<UserEntity?> login(String email, String password) async {
    try {
      final response = await client.auth
          .signInWithPassword(email: email, password: password)
          .timeout(Duration(minutes: 1));
      final user =response.user;
      if (user == null) {
        throw AuthApiException(
          'Invalid login credentials ',
          statusCode: '400',
          code: 'invalid_credentials',
        );
      }
      LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED_user, true);
      return UserEntity(id: user.id, email: email);
    } on TimeoutException {
      throw AuthApiException('Connection timed out. Please try again.');
    } on AuthRetryableFetchException catch (e) {
      debugPrint('Supabase unreachable: ${e.message}');
      throw AuthApiException(
        'Server is temporarily unavailable. Please try again.',
      );
    } on HandshakeException catch (e) {
      // This confirms it's a network/SSL issue
      print('SSL Handshake failed: ${e.message}');
      throw AuthApiException(
        'Network security error. Please check your connection.',
      );
    } on AuthException catch (e) {
      throw AuthApiException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('Unexpected error :$e');
    }
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
    LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED_user, false);
  }

  @override
  Future<UserEntity?> signup(String email, String password) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'cleanarch:/${RouteNames.login}',
      );
      final user = response.user;
      if (user == null) {
        return null;
      } else {
        //LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED_user, true);
        return UserEntity(id: user.id, email: email);
      }
    } on AuthException catch (e) {
      throw Exception('Login failed :$e');
    } catch (e) {
      throw Exception('Unexpected error :$e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'cleanarch:/${RouteNames.newPass}',
      );
      debugPrint("Password reset email sent");
    } on AuthApiException catch (e) {
      debugPrint("Supabase error: ${e.message}");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      debugPrint("Password updated successfully");
    } catch (e) {
      debugPrint("Error updating password: $e");
    }
  }
}
