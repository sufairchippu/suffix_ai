import 'dart:developer';
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
    required String papperType,

    String? topic,
    String? time,
    String? mark,
    required String questionData,
  }) async {
    try {
      if (questionData.trim().isEmpty) {
        log('$questionData>>>>>>>>');
        return left(SomeSpecificError('AI returned empty question data'));
      }
      log('eroor happaning hehre');
      final pdf = await dataSource.genratepdfQuestions(
        description: description ?? '',
        papperCode: papperCode ?? '',
        subTopic: subTopic ?? '',
        universityName: universityName ?? '',
        // questionCount: questionCount,
        // categeory: categeory,
        // level: level,
        mark: mark ?? '',
        papperType: papperType,
        time: time ?? '',
        topic: topic ?? '',
        questionData: questionData,
      );
      return right(pdf);
    } catch (e) {
      log("error $e >>>>>>.");
      return left(SomeSpecificError(e.toString()));
    }
  }
}
