import 'dart:typed_data';

import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/quiz/business/repo/pdf_genration_repo.dart';
import 'package:clean_architutre_learn/features/quiz/data/data_sources/pdf_genration_datasource.dart';
import 'package:dartz/dartz.dart';

class PdfGenerationRepoImpl implements PdfGenrationRepo {
  final PdfGenrationDatasource dataSource;
  PdfGenerationRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, Uint8List>> genrateMCQpdf({
    String? description,
    String? subTopic,
    String? universityName,
    String? papperCode,
  }) async {
    try {
      final pdf = await dataSource.genratepdfQuestions(
        description: description,
        papperCode: papperCode,
        subTopic: subTopic,
        universityName: universityName,
      );
      return right(pdf);
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
    }
  }
}
