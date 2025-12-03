import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_gemini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dioClientProviderGemini = Provider<DioClientGemini>((ref) {
  final dio = ref.watch(dioProviderGemini);
  return DioClientGemini(dio);
});

final dioProviderGemini = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      // baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),

      contentType: 'application/json',
      // headers: {
      //   'Content-Type': 'application/json',
      //   'X-goog-api-key': AppConfig.aiApiKey,
      // },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['X-goog-api-key'] = AppConfig.aiApiKey;
        // options.headers['Content-Type'] = 'application/json';
        // options.contentType

        // Add token if needed
        return handler.next(options);
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



// class DioClient{
// final dioProvider = Provider<Dio>((ref) {
// final   dio = Dio(
//     BaseOptions(
//       baseUrl: ApiUrl.baseUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {'Content-Type': 'application/json'},
//     ),
//   );
//   dio.interceptors.add(
//       InterceptorsWrapper(
//             onRequest: (options, handler) async {
//               // String autToken = LocalStorageService.getString(
//               //   LocalStorageKey.USER_TOKEN_KEY,
//               // );

//               // if ((autToken.isNotEmpty) &&
//               //     !options.path.contains('login') &&
//               //     !options.path.contains('ClinicRegister')) {
//               //   options.headers['Authorization'] = 'Bearer $autToken';
//               //   options.headers['Accept'] = 'application/json';
//               // }
//               // return handler.next(options);
//             },
//             onError: (DioException e, handler) {
//               if (e.type == DioExceptionType.connectionTimeout ||
//                   e.type == DioExceptionType.receiveTimeout ||
//                   e.type == DioExceptionType.sendTimeout) {
//                 log("⚠️ Network Error: Slow or No Internet Connection");
//               }
//               return handler.next(e);
//             },
//           ),
//     // LogInterceptor(responseBody: true,)
//   );
//   return dio;
// });




//   static Future<dynamic> get(
//     String uri, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     void Function(int, int)? onReceiveProgress,
//   }) async {
//     try {
//       final Response response =  dioProvider.get(
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

//   static Future<dynamic> post(
//     String uri, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     void Function(int, int)? onSendProgress,
//     void Function(int, int)? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await dioProvider.post(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
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

//   static Future<dynamic> put(
//     String uri, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     void Function(int, int)? onSendProgress,
//     void Function(int, int)? onReceiveProgress,
//   }) async {
//     try {
//       final Response response = await dioProvider.put(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
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

//   static Future<dynamic> delete(
//     String uri, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final Response response = await dioProvider.delete(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
   