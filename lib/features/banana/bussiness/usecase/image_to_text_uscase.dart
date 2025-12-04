import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/repo/image_genration_repo.dart';
import 'package:dartz/dartz.dart';


class ImageToTextUscase {
  final ImageGenrationRepo repo;
  ImageToTextUscase(this.repo);
  Future<Either<Failure, Uint8List?>> call({required String prompt}) async {
    return await repo.genrateImageFromText(prompt);
  }
}
