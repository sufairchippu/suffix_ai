import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  static late FlutterSecureStorage _secureStorage;

  /// Initialize storages
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
  }

  // --------- SharedPreferences (Non-sensitive data) ---------
  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    return _prefs.getInt(key) ?? defaultValue;
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static bool getUserLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<bool> removeValue(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> logout() async {
    try {
      await Future.wait([
        _prefs.clear(),
        setBool('isLoggedIn', false),
      ]);
      return true;
    } catch (e) {
      return false;
    }
  }

  // --------- FlutterSecureStorage (Sensitive data) ---------
  static Future<void> setSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecure(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }
}
