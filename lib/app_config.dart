import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/api_url.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // API URLs
  static String get stagingUrl => dotenv.env['STAGING_URL'] ?? '';
  static String get mainUrl =>
      dotenv.env['MAIN_URL'] ?? ''; //superbase currentlyy

  // API KEYS
  static String get superbaseAnonKey => dotenv.env['SUPERBASE_ANON'] ?? '';
  static String get superbasePubishKey =>
      dotenv.env['SUPERBASE_PUBLISHABLE'] ?? '';
  static String get aiApiKey => dotenv.env[ApiUrl.kAIAPI] ?? '';
  static String get imaginAPIToken => dotenv.env[ApiUrl.kIMAGINEAPI] ?? '';
  static String get imaginAIUrl => 'https://api.vyro.ai/v2/';
  static String get googleImagAIUrl =>
      "https://generativelanguage.googleapis.com/v1beta/models/";
}
