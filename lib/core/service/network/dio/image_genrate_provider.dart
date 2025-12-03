import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_gemini.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterNumberNano = StateProvider<int>((ref) => 0);
final dioClientImagineProvider = Provider<DioClientGemini>((ref) {
  final dio = ref.watch(dioImagineNotifier);
  return DioClientGemini(dio);
});
final dioImagineNotifier = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: 'Bearer ${AppConfig.imaginAPIToken}'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Authorization'] = 'Bearer ${AppConfig.imaginAPIToken}';
        return handler.next(options);

        // options.headers['X-goog-api-key'] = AppConfig.aiApiKey;
        // options.headers['Content-Type'] = 'application/json';
        // options.contentType

        // Add token if needed
        // return handler.next(options);
      },
      onError: (e, handler) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          debugPrint("⚠️ Network Error: Slow or No Internet Connection");
        }
        return handler.next(e);
      },
    ),
  );
  return dio;
});
