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
import 'dart:io';

import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_gemini.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_coonstants.dart/api_url.dart';
import '../model/ai_response_model.dart';

class AiDataSource {
  final DioClientGemini client;
  AiDataSource(this.client);

  final List<Map<String, dynamic>> conversationHistory = [];

  Future<Content?> getAiResponse({
    required String userAsking,
    List<File>? files,
  }) async {
    try {
      ///here fetch the sqlite data and store in the>>>>>>>>>>>>>>>> conversationHistory

      // ✅ Create list of message parts (text + optional attachments)
      final List<Map<String, dynamic>> userParts = [
        {"text": userAsking},
      ];

      if (files != null) {
        for (File file in files) {
          final mimeType = _getMimeType(file.path);
          userParts.add({
            "inline_data": {
              "mime_type": mimeType,
              "data": base64Encode(await file.readAsBytes()),
            },
          });
        }
      }

      // if (documentFile != null) {
      //   final mimeType = _getMimeType(documentFile.path);
      //   userParts.add({
      //     "inline_data": {
      //       "mime_type": mimeType,
      //       "data": base64Encode(await documentFile.readAsBytes()),
      //     },
      //   });
      // }

      // ✅ Add the user message to chat history
      conversationHistory.add({"role": "user", "parts": userParts});

      // ✅ Construct final request body with all history
      final body = {"contents": conversationHistory};

      // ✅ Send to Gemini API
      final response = await client.post(
        "${ApiUrl.baseGeminiUrl}?key=${AppConfig.aiApiKey}",
        data: jsonEncode(body),
      );

      if (response is Map<String, dynamic>) {
        final aiResponseModel = AiResponseModel.fromJson(response);
        final content = aiResponseModel.candidates?.first.content;

        // ✅ Extract AI text and add to history
        final aiText = content?.parts?.first.text ?? "⚠️ No response";
        conversationHistory.add({
          "role": "model",
          "parts": [
            {"text": aiText},
          ],
        });

        return content;
      } else {
        log("⚠️ Unexpected response format: $response");
      }
    } on DioException catch (e) {
      log("❌ DioException: ${e.response?.statusCode}");
      log("❌ Error data: ${e.response?.data}");
      rethrow;
    } catch (e, st) {
      log("❌ General error: $e");
      log(st.toString());
    }

    return null;
  }

  // 🧩 Detect MIME type based on file extension
  String _getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }
}
