import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/api_coonstants.dart/end_points.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_methods.dart';
import 'package:dio/dio.dart';

class ImaginDatasource {
  final DioClientMethods dio;
  ImaginDatasource(this.dio);

  Future<Uint8List?> imageFromImage({
    required String imagePath,
    required String prompt,
    String model = "imagen-3.0",
    int size = 1024,
  }) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);
      final formData = FormData.fromMap({
        'prompt': '{"prompt": $prompt,"imge_bytes": $base64Image}',
        'style': 'realistic',
        'aspect_ratio': '1:1',
        'seed': 5,
      });
      // final formData = {
      //   "prompt": prompt,
      //   "image": {"mimeType": "image/png", "bytes": base64Image},
      //   // "model": model,
      //   // "image": base64,
      //   // "prompt": prompt,
      //   // "size": "${size}x$size",
      //   // "response_format": "b64_json",
      //   // "input": [
      //   //   {
      //   //     "image": {"data": base64},
      //   //   },
      //   //   {"text": prompt},
      //   // ],
      //   // "output": {"format": "image/png", "shape": "square_hd"},
      // };

      final Uint8List? response = await dio.post(
        // options: Options(contentType: Headers.multipartFormDataContentType),
        EndPoints.imageFromText,
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          responseType: ResponseType.bytes,
        ),
      );
      final data = response;
      if (data == null) {
        log('Cant genrate the image');
        return null;
      }

      return Uint8List.fromList(data);
    } catch (e) {
      log('Eror :$e');
      return null;
    }
  }

  // Future<Uint8List?> genrateImageFromText({
  //   required String prompt,
  //   int size = 1024,
  // }) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       "model": "imagen-3.0",
  //       "prompt": prompt,
  //       "size": "${size}x$size",
  //       "response_format": "b64_json",
  //     });
  //     final response = await dio.post(EndPoints.imageFromText, data: formData);
  //     final base64 = response.data['data'][0]["b64_json"];
  //     return base64Decode(base64);
  //   } catch (e) {
  //     log("ERROR: $e");
  //     return null;
  //   }
  // }
}
