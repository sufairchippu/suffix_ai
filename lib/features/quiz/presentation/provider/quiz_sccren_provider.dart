import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:clean_architutre_learn/features/quiz/business/repo/pdf_genration_repo.dart';
import 'package:clean_architutre_learn/features/quiz/business/usecases/pdf_genration_uscase.dart';
import 'package:clean_architutre_learn/features/quiz/data/data_sources/pdf_genration_datasource.dart';
import 'package:clean_architutre_learn/features/quiz/data/repo/pdf_generation_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizselectedAnswerProvider = StateProvider<String>((ref) {
  return '';
});
final paperTypeOptionProvider = StateProvider<String?>((ref) {
  return;
});
final topicOptionProvider = StateProvider<String?>((ref) {
  return;
});
final categeoryOptionProvider = StateProvider<String?>((ref) {
  return;
});
final searchQueryProvider = StateProvider<String>((ref) => '');
final optionalFormfieldProvider = StateProvider((ref) => false);
final questionCountProvider = StateProvider((ref) => 20);
final maxMarkProvider = StateProvider((ref) => 100);
final timeNumberProvider = StateProvider((ref) => 120);

final pdfGenrationDatasourceProvider = Provider(
  (ref) => PdfGenrationDatasource(),
);
final pdfGenarationRepoProvider = Provider<PdfGenrationRepo>((ref) {
  final dataSource = ref.read(pdfGenrationDatasourceProvider);
  return PdfGenerationRepoImpl(dataSource);
});
final pdfGenrationProvider = Provider((ref) {
  final repo = ref.read(pdfGenarationRepoProvider);
  return PdfGenrationUscase(repo);
});
//!  providers for each type pdf genration

class PdfGenrationNotifier extends StateNotifier<AsyncValue<Uint8List?>> {
  final PdfGenrationUscase _genratePdf;
  PdfGenrationNotifier(this._genratePdf) : super(const AsyncValue.data(null));
  Future<void> genratePdf({
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
    state = const AsyncLoading();
    final result = await _genratePdf(
      papperType: papperType,
      questionData: questionData,
      mark: mark,
      time: time,
      topic: topic,
      description: description,
      papperCode: papperCode,
      subTopic: subTopic,
      universityName: universityName,
    );
    
    return result.fold(
      (l) => state = AsyncError(l, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final pdfGenrationNotifierProvider =
    StateNotifierProvider<PdfGenrationNotifier, AsyncValue<Uint8List?>>(
      (ref) => PdfGenrationNotifier(ref.read(pdfGenrationProvider)),
    );
