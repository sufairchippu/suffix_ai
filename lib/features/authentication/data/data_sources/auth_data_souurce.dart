import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/service/network/dio/superbase_provider.dart';
import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:clean_architutre_learn/features/authentication/business/entities/user_entity.dart';
import 'package:clean_architutre_learn/features/authentication/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSouurce {
  // final DioClientSuperBase client;
  AuthDataSouurce();
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> signup(String email, String password);
  Future<void> logout();
  UserEntity? currentUser();
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
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        return null;
      } else {
        LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED, true);
        return UserEntity(id: user.id, email: email);
      }
    } on AuthException catch (e) {
      throw Exception('Login failed :$e');
    } catch (e) {
      throw Exception('Unexpected error :$e');
    }
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
    LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED, true);
  }

  @override
  Future<UserEntity?> signup(String email, String password) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        return null;
      } else {
        LocalStorageService.setBool(LocalServiceKeys.IS_LOGGED, true);
        return UserEntity(id: user.id, email: email);
      }
    } on AuthException catch (e) {
      throw Exception('Login failed :$e');
    } catch (e) {
      throw Exception('Unexpected error :$e');
    }
  }
}
