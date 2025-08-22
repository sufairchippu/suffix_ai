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
      var respons = await client.post(AppConfig.aiApiKey);
      log(
        "tracking executuve dropdown list API Response   = = = = = = = = = = = = : $respons",
      );
      if (respons is Map<String, dynamic>) {
        final content = AiResponseModel.fromJson(
          respons,
        ).candidates![0].content!;
        return content;
      }else{
         log(
          "Unexpected response format in ai hitting : $respons",
        );
      }
    }on DioException catch (e) {
        log(
        "DioException in in ai hitting: ${e.response?.statusCode}",
      );
      log(
        "Error message in ai hitting : ${e.response?.data}",
      );
      rethrow;
    }
    return null;
    
  }
}
