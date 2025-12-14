import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/service/pdf/pdf_service.dart';
import 'package:clean_architutre_learn/core/service/segment/segment_provider.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/ai_provider.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/mcq_paper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/short_answer_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/tasc_papper_model.dart';
import 'package:clean_architutre_learn/features/quiz/data/model/university_normal_model.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/provider/quiz_sccren_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfGenrationDatasource {
  final Ref ref;
  PdfGenrationDatasource(this.ref);

  Future<Uint8List> genratepdfQuestions({
    String? description,
    String? subTopic,
    String? universityName,
    String? papperCode,
  }) async {
    final papperType = ref.read(paperTypeOptionProvider);
    final level = ref.read(segmentSelectionLevelProvider);
    final topic = ref.read(topicOptionProvider);
    final time = ref.read(timeNumberProvider);
    final mark = ref.read(maxMarkProvider);
    // final categrory = ref.read(categeoryOptionProvider);

    final questionCount = ref.read(questionCountProvider);
    String prompt = '';
    if (papperType == CoreConstants.qustionText[0]) {
      prompt =
          'Generate $questionCount multiple-choice questions about flutter. Difficulty: $level. Format in JSON with fields: question, options, correct_answer_index, difficulty';
    }

    if (ref.watch(paperTypeOptionProvider) == CoreConstants.qustionText[1]) {
      prompt =
          """
Generate EXACTLY $questionCount questions on "$topic"
${(subTopic != null && subTopic.isNotEmpty) ? 'focused on "$subTopic"' : ''}.

Difficulty level: $level.

Rules:
- Each answer MUST be a single word or a single short line.
- Do NOT include explanations.
- Do NOT include markdown.


Return STRICTLY valid JSON in the following format:

{
  "one_word_paper": [
    {
      "question": "string",
      "answer": "string"
    }
  ]
}
""";
    }
    if (ref.watch(paperTypeOptionProvider) == CoreConstants.qustionText[2]) {
      prompt =
          """
                  Generate a TASC-style exam with $questionCount questions on "$topic"${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
                  Difficulty: $level.

                  Return STRICT JSON only:
                  {
                    "tasc_paper": [
                      {
                        "question": "string",
                        "description": "string",
                        "answer": "string"
                      }
                    ]
                  }
           
                  """;
    }

    if (ref.watch(paperTypeOptionProvider) == CoreConstants.qustionText[3]) {
      prompt =
          """
              Generate an exam paper on '$topic'${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
              Difficulty: $level.
              Number of Questions: $questionCount.
              Include:
              - Short Answer (4)
              - MCQ (2)
              - Medium Long (3)
              - Essay (1)

              Return valid JSON:
              {
                "exam_paper": [
                  { "type": "short_answer", "question": "...", "answer": "..." },
                  { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
                  { "type": "long_answer", "question": "...", "answer": "..." },
                  { "type": "essay", "question": "...", "answer": "..." }
                ]
              }
                  """;
    }
    if (ref.watch(paperTypeOptionProvider) == CoreConstants.qustionText[4]) {
      prompt =
          """
                  Generate a university-style exam on "$topic"${(subTopic != null && subTopic.isNotEmpty) ? 'with $subTopic' : ''}.
                  Total questions required: $questionCount.
                  1 question may be ignored (exception rule).
                  Difficulty: $level.

                  Return STRICT JSON:
                  {
                    "university_paper": {
                      "ignore_question_count": 1,
                      "questions": [
                        {
                          "question": "string",
                          "marks": 5,
                          "              ": "string"
                        }
                      ]
                    }
                  }
                  """;
    }
    await ref.read(aiMessgeNotifierProvider.notifier).getAiReply(data: prompt);
    final reply = ref.watch(aiMessgeNotifierProvider);

    final response = reply.parts![0].text!
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();
    log('$response............... reponse of aimsg');
    dynamic questionData;
    final dynamic data = jsonDecode(response);

    if (papperType == CoreConstants.qustionText[0]) {
      questionData = data.map((e) => McqQuestion.fromJson(e)).toList();
    } else if (papperType == CoreConstants.qustionText[1]) {
      questionData = ShortAnswerModel.fromJson(data).questionModel;
    } else if (papperType == CoreConstants.qustionText[2]) {
      questionData = TascPapperModel.fromJson(data).tasqPapper;
    } else if (papperType == CoreConstants.qustionText[3]) {
      questionData = UniversityTypeModel.fromJson(data).examPaper;
    } else if (papperType == CoreConstants.qustionText[4]) {}
    return await PdfService.genratPdf(
      questionData: questionData,
      papperType: papperType!,
      topic: topic!,
      mark: mark.toString(),
      subtopic: subTopic,
      pappercode: papperCode,
      discription: description,
      time: time.toString(),
      universityName: universityName,
    );

    // throw Exception("Unsupported paper type");
  }
}
