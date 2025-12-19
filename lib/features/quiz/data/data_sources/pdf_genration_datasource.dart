import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/service/pdf/pdf_service.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/mcq_paper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/short_answer_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/tasc_papper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/university_normal_model.dart';

class PdfGenrationDatasource {
  // final Ref ref;
  // PdfGenrationDatasource(this.ref);

  Future<Uint8List> genratepdfQuestions({
    String? description,
    String? subTopic,
    String? universityName,
    String? papperCode,
    required String papperType,
    // String? level,
    String? topic,
    String? time,
    String? mark,
    // String? categeory,
    // required int questionCount,
    required String questionData,
  }) async {
    // final papperType = ref.read(paperTypeOptionProvider);
    // final level = ref.read(segmentSelectionLevelProvider);
    // final topic = ref.read(topicOptionProvider);
    // final time = ref.read(timeNumberProvider);
    // final mark = ref.read(maxMarkProvider);

    // final categrory = ref.read(categeoryOptionProvider);

    // final questionCount = ref.read(questionCountProvider);
    //     String prompt = '';
    //     if (papperType == CoreConstants.qustionText[0]) {
    //       prompt =
    //           'Generate $questionCount multiple-choice questions about $topic. Difficulty: $level. Format in JSON with fields: question, options, correct_answer_index, difficulty';
    //     } else if (papperType == CoreConstants.qustionText[1]) {
    //       prompt =
    //           """
    // Generate EXACTLY $questionCount questions on "$topic"
    // ${(subTopic != null && subTopic.isNotEmpty) ? 'focused on "$subTopic"' : ''}.

    // Difficulty level: $level.

    // Rules:
    // - Each answer MUST be a single word or a single short line.
    // - Do NOT include explanations.
    // - Do NOT include markdown.

    // Return STRICTLY valid JSON in the following format:

    // {
    //   "one_word_paper": [
    //     {
    //       "question": "string",
    //       "answer": "string"
    //     }
    //   ]
    // }
    // """;
    //     } else if (papperType == CoreConstants.qustionText[2]) {
    //       prompt =
    //           """
    //                   Generate a TASC-style exam with $questionCount questions on "$topic"${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
    //                   Difficulty: $level.

    //                   Return STRICT JSON only:
    //                   {
    //                     "tasc_paper": [
    //                       {
    //                         "question": "string",
    //                         "description": "string",
    //                         "answer": "string"
    //                       }
    //                     ]
    //                   }

    //                   """;
    //     } else if (papperType == CoreConstants.qustionText[3]) {
    //       const totalRatio = 4 + 2 + 3 + 1;

    //       final shortAnswer = (questionCount * 4) ~/ totalRatio;
    //       final mcq = (questionCount * 2) ~/ totalRatio;
    //       final mediumLong = (questionCount * 3) ~/ totalRatio;
    //       final essay = (questionCount * 1) ~/ totalRatio;
    //       prompt =
    //           """
    //               Generate an exam paper on '$topic'${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
    //               Difficulty: $level.
    //               Number of Questions: $questionCount.
    //               Include:
    //               - Short Answer ($shortAnswer)
    //               - MCQ ($mcq)
    //               - Medium Long ($mediumLong)
    //               - Essay ($essay)

    //               Return valid JSON:
    //               {
    //                 "exam_paper": [
    //                   { "type": "short_answer", "question": "...", "answer": "..." },
    //                   { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
    //                   { "type": "long_answer", "question": "...", "answer": "..." },
    //                   { "type": "essay", "question": "...", "answer": "..." }
    //                 ]
    //               }
    //                   """;
    //     } else if (papperType == CoreConstants.qustionText[4]) {
    //       const totalRatio = 4 + 2 + 3 + 1;

    //       final shortAnswer = (questionCount * 4) ~/ totalRatio;
    //       final mcq = (questionCount * 2) ~/ totalRatio;
    //       final mediumLong = (questionCount * 3) ~/ totalRatio;
    //       final essay = (questionCount * 1) ~/ totalRatio;
    //       prompt =
    //           """
    //                   Generate a university-style exam on "$topic"${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
    //                   Total questions required: $questionCount.
    //                   Difficulty: $level.

    //               Include:
    //                   1 question may be ignored (exception rule).for every section

    //               - Short Answer ($shortAnswer)
    //               - MCQ ($mcq)
    //               - Medium Long ($mediumLong)
    //               - Essay ($essay)
    //                  {
    //                 "exam_paper": [
    //                   { "type": "short_answer", "question": "...", "answer": "..." },
    //                   { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
    //                   { "type": "long_answer", "question": "...", "answer": "..." },
    //                   { "type": "essay", "question": "...", "answer": "..." }
    //                 ]
    //               }
    //                   """;
    //     } else {
    //       prompt = '';
    //     }
    // await ref
    //     .read(aiMessgeNotifierProvider.notifier)
    //     .getAiReply(data: prompt, toSupabase: false);
    // final reply = ref.read(aiMessgeNotifierProvider);

    final response = questionData
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();
    log('$response............... reponse of aimsg');
    final dynamic data = jsonDecode(response);
    final modelData = _resplveModeldata(papperType: papperType, data: data);

    log("Building pdf page >>>>>>>>>>>>>>>>>>>>>>>>>>");

    return await PdfService.genratPdf(
      questionData: modelData,
      papperType: papperType,
      topic: topic ?? 'GK',
      mark: mark,
      subtopic: subTopic,
      pappercode: papperCode,
      discription: description,
      time: time,
      universityName: universityName,
    );

    // throw Exception("Unsupported paper type");
  }

  dynamic _resplveModeldata({
    required String papperType,
    required dynamic data,
  }) {
    if (papperType == CoreConstants.qustionText[0]) {
      return McqPaperModel.fromJson(data).questions;
    } else if (papperType == CoreConstants.qustionText[1]) {
      return ShortAnswerModel.fromJson(data).questionModel;
    } else if (papperType == CoreConstants.qustionText[2]) {
      return TascPapperModel.fromJson(data).tasqPapper;
    } else if (papperType == CoreConstants.qustionText[3] ||
        papperType == CoreConstants.qustionText[4]) {
      return UniversityTypeModel.fromJson(data).examPaper;
    } else {
      throw Exception('Unsupported paper type: $papperType');
    }
  }
}
