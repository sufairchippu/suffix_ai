import 'dart:io';

import 'package:clean_architutre_learn/features/chat/business/repo/ai_responce_repository.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetMessage {
  final AiResponceRepository repo;
  GetMessage(this.repo);
  Future<Either<Failure, Content>> call({
    required String data,
    List<File>? files,
  }) {
    return repo.getMessage(data: data, files: files);
  }
}
