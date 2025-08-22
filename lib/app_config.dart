import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/api_url.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // API URLs
  static final String stagingUrl = dotenv.env['STAGING_URL'] ?? '';
  static final String mainUrl = dotenv.env['MAIN_URL'] ?? '';

  // API KEYS
  static final String mapsApiKey = dotenv.env[ApiUrl.kMAPSAPIKEY] ?? '';
  static final String paymentApiKey = dotenv.env[ApiUrl.kPAYMENTAPIKEY] ?? '';
  static final String aiApiKey = dotenv.env[ApiUrl.kAIAPI] ?? '';
}
