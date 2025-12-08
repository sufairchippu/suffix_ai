import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ImageGenrationRepo {
  // Future<Either<Failure, Uint8List>> genrateImageFromText(
  //   String prompt,

  //   //= 5,
  // );

  //   Future<Response?> genrateVideoFromText(
  //     String prompt,
  //     String style, //= "kling-1.0-pro",
  //   );
  Future<Either<Failure, Uint8List>> genrateImageFromImage({
    required String imagePath,
    required String prompt,
  });

  //   Future<Response?> genrateVideoFromImage({
  //     required String imagePath,
  //     required String prompt,
  //     String style,
  //   });

}
