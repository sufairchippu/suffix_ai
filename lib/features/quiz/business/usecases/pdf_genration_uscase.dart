import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/quiz/business/repo/pdf_genration_repo.dart';
import 'package:dartz/dartz.dart';

class PdfGenrationUscase {
  final PdfGenrationRepo repo;
  PdfGenrationUscase(this.repo);
  Future<Either<Failure, Uint8List>> call({
    String? description,
    String? subTopic,
    String? universityName,
    String? papperCode,
    required String papperType,

    String? topic,
    String? time,
    String? mark,
    required String questionData,
  }) async {
    return repo.genrateMCQpdf(
      papperCode: papperCode,
      subTopic: subTopic,
      universityName: universityName,
      papperType: papperType,
      questionData: questionData,
      description: description,
      mark: mark,
      time: time,
      topic: topic,
    );
  }
}
