import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dioClientProviderSuperBase = Provider<DioClientMethods>((ref) {
  final dio = ref.watch(dioProviderSuperbase);
  return DioClientMethods(dio);
});

final dioProviderSuperbase = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: '${AppConfig.mainUrl}/rest/v1/',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),

      contentType: 'application/json',
      headers: {
        'apikey': AppConfig.superbaseAnonKey,
        'Authorization':
            'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken ?? ''}',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final aceestoken =
            Supabase.instance.client.auth.currentSession?.accessToken;
        if (aceestoken != null) {
          options.headers['Authorization'] = 'Bearer $aceestoken';
        }
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

// class DioClientSuperBase {
//   final Dio _dio;

//   DioClientSuperBase(this._dio);

//   Future<dynamic> get(
//     String uri, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     void Function(int, int)? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.get(
//         uri,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<dynamic> post(
//     String uri, {
//     dynamic data,
//     Options? options,
//     CancelToken? cancelToken,
//     void Function(int, int)? onSendProgress,
//     void Function(int, int)? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.post(
//         uri,
//         data: data,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
