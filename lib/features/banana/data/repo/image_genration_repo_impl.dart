import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/repo/image_genration_repo.dart';
import 'package:clean_architutre_learn/features/banana/data/data_source/imagin_datasource.dart';
import 'package:dartz/dartz.dart';

class ImageGenrationRepoImpl implements ImageGenrationRepo {
  final ImaginDatasource datasource;
  ImageGenrationRepoImpl(this.datasource);

  @override
  Future<Either<Failure, Uint8List?>> genrateImageFromImage({
    required String imagePath,
    required String prompt,
  }) async {
    try {
      final getimage = await datasource.imageFromImage(
        imagePath: imagePath,
        prompt: prompt,
      );
      return right(getimage);
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Uint8List?>> genrateImageFromText(
    String prompt,
  ) async {
    try {
      final getimage = await datasource.genrateImageFromText(prompt: prompt);
      return right(getimage);
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }

  // @override
  // Future<Response<dynamic>?> genrateVideoFromImage({
  //   required String imagePath,
  //   required String prompt,
  //   String style,
  // }) {
  //   // TODO: implement genrateVideoFromImage
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Response<dynamic>?> genrateVideoFromText(String prompt, String style) {
  //   // TODO: implement genrateVideoFromText
  //   throw UnimplementedError();
  // }
}
