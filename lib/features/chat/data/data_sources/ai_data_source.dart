import 'dart:convert';
import 'dart:developer';

import 'package:clean_architutre_learn/app_config.dart';
import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/api_url.dart';
import 'package:clean_architutre_learn/core/service/network/dio_provider.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:dio/dio.dart';

class AiDataSource {
  final DioClient client;
  AiDataSource(this.client);

  Future<Content?> getAiresponse(String userAsking) async {
    try {
      // Map<String, dynamic> body = {'X-goog-api-key': ''};
      Map<String, dynamic> body = {
        "contents": [
          {
            "parts": [
              {"text": userAsking},
            ],
          },
        ],
      };

      var respons = await client.post(ApiUrl.baseUrl, data: jsonEncode(body));

      if (respons is Map<String, dynamic>) {
        final content = AiResponseModel.fromJson(
          respons,
        ).candidates![0].content!;
        log("Unexpected response format in ai hitting : $content");

        return content;
      } else {
        log("Unexpected response format in ai hitting : $respons");
      }
    } on DioException catch (e) {
      log("DioException in in ai hitting: ${e.response?.statusCode}");
      log("Error message in ai hitting : ${e.response?.data}");
      rethrow;
    }
    return null;
  }
}
