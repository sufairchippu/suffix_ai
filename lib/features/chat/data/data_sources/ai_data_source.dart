// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/api_url.dart';
// import 'package:clean_architutre_learn/core/service/network/dio_provider.dart';
// import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
// import 'package:dio/dio.dart';

// class AiDataSource {
//   final DioClient client;
//   AiDataSource(this.client);
// // final _controller= StreamController<Content>.broadcast();
//   Future<Content?> getAiresponse(String userAsking) async {
//     try {
//       // Map<String, dynamic> body = {'X-goog-api-key': ''};
//       Map<String, dynamic> body = {
//         "contents": [
//           {
//             "parts": [
//               {"text": userAsking},
//             ],
//           },
//         ],
//       };

//       var respons = await client.post(ApiUrl.baseUrl, data: jsonEncode(body));

//       if (respons is Map<String, dynamic>) {
//         final content = AiResponseModel.fromJson(
//           respons,
//         ).candidates![0].content!;
//         log("Unexpected response format in ai hitting : $content");

//         return content;
//       } else {
//         log("Unexpected response format in ai hitting : $respons");
//       }
//     } on DioException catch (e) {
//       log("DioException in in ai hitting: ${e.response?.statusCode}");
//       log("Error message in ai hitting : ${e.response?.data}");
//       rethrow;
//     }
//     return null;
//   }

// }

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_coonstants.dart/api_url.dart';
import '../../../../core/service/network/dio/gemini_provider.dart';
import '../model/ai_response_model.dart';

class AiDataSource {
  final DioClient client;
  AiDataSource(this.client);

  final List<Map<String, dynamic>> conversationHistory = [];

  Future<Content?> getAiresponse(String userAsking) async {
    try {
      // Add user message
      conversationHistory.add({
        "role": "user",
        "parts": [
          {"text": userAsking},
        ],
      });

      Map<String, dynamic> body = {"contents": conversationHistory};

      var response = await client.post(ApiUrl.baseUrl, data: jsonEncode(body));

      if (response is Map<String, dynamic>) {
        final aiResponseModel = AiResponseModel.fromJson(response);
        final content = aiResponseModel.candidates![0].content!;

        // Extract AI text and add it to history
        final aiText = content.parts?.first.text ?? "";
        conversationHistory.add({
          "role": "model",
          "parts": [
            {"text": aiText},
          ],
        });

        return content;
      } else {
        log("Unexpected response format: $response");
      }
    } on DioException catch (e) {
      log("DioException: ${e.response?.statusCode}");
      log("Error: ${e.response?.data}");
      rethrow;
    }
    return null;
  }
}
