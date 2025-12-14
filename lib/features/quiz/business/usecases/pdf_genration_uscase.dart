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
  }) async {
    return repo.genrateMCQpdf(
      papperCode: papperCode,
      subTopic: subTopic,
      universityName: universityName,
    );
  }
}
