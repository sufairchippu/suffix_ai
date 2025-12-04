import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/repo/image_genration_repo.dart';
import 'package:dartz/dartz.dart';


class ImageToImageUscase {
  final ImageGenrationRepo repo;
  ImageToImageUscase(this.repo);
 Future<Either<Failure,Uint8List?>> call(
    String prompt,
    String imagePath,

    // String aspectRatio = "1:1",
    // int seed = 5,
  ) async {
    return await repo.genrateImageFromImage(
      imagePath: imagePath,
      prompt: prompt,
    );
  }
}
