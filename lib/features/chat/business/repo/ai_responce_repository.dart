import 'dart:io';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/ai_response_model.dart';

abstract class AiResponceRepository {
  Future<Either<Failure, Content>> getMessage({
    required String data,
    File? imageFile,
    File? documentFile,
  });
}
