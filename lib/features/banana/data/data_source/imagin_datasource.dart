import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/end_points.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_gemini.dart';
import 'package:dio/dio.dart';

class ImaginDatasource {
  final DioClientGemini dio;
  ImaginDatasource(this.dio);

  Future<Uint8List?> imageFromImage({
    required String imagePath,
    required String prompt,
    String model = "imagen-3.0",
    int size = 1024,
  }) async {
    try {
      final formData = FormData.fromMap({
        "model": model,
        "image": await MultipartFile.fromFile(imagePath),
        "prompt": prompt,
        "size": "${size}x$size",
        "response_format": "b64_json",
      });

      final response = await dio.post(EndPoints.imageFromImage, data: formData);
      final base64 = response.data['data'][0]["b64_json"];
      return base64Decode(base64);
    } catch (e) {
      log('Eror :$e');
      return null;
    }
  }

  Future<Uint8List?> genrateImageFromText({
    required String prompt,
    int size = 1024,
  }) async {
    try {
      final formData = FormData.fromMap({
        "model": "imagen-3.0",
        "prompt": prompt,
        "size": "${size}x$size",
        "response_format": "b64_json",
      });
      final response = await dio.post(EndPoints.imageFromText, data: formData);
      final base64 = response.data['data'][0]["b64_json"];
      return base64Decode(base64);
    } catch (e) {
      log("ERROR: $e");
      return null;
    }
  }
}
