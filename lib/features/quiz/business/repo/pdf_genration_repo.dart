import 'dart:typed_data';

import 'package:clean_architutre_learn/core/constants/core_constants.dart';
import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PdfGenrationRepo {
  Future<Either<Failure, Uint8List>> genrateMCQpdf({
    String? description,
    String? subTopic,
    String? universityName,
    String? papperCode,
  });
}
  // Future<Uint8List> genrateNormalpdf();
  // Future<Uint8List> genrateOneWordpdf();
  // Future<Uint8List> genrateTascpdf();
  // Future<Uint8List> genrateUNivercitypdf();

  // static String creatingMCQpapper(int number, String topic, Diffculty diff) {
  //   return 'Generate $number multiple-choice questions about $topic. Difficulty: $diff. Format in JSON with fields: question, options, correct_answer_index, difficulty';
  // }

  // static String creatingNormalpapper(int number, String topic, Diffculty diff) {
  //   return "Generate an exam paper on '$topic'.\nDifficulty: $diff.\nNumber of Questions: $number.\nInclude a mix of:\n- Short Answer Questions\n- Multiple Choice Questions\n- Medium Long Answer Questions\n- Essay Questions\nin the ratio of 4:2:3:1.\n\nFormat the output as a valid JSON object with the following structure:\n{\n  \"exam_paper\": [\n    { \"type\": \"short_answer\", \"question\": \"...\", \"answer\": \"...\" },\n    { \"type\": \"mcq\", \"question\": \"...\", \"options\": [\"...\"], \"answer_index\": \"...\" },\n    { \"type\": \"long_answer\", \"question\": \"...\", \"answer\": \"...\" },\n    { \"type\": \"essay\", \"question\": \"...\", \"answer\": \"...\" }\n  ]\n}";
  // }


// class PaperGeneratorPromt {
//   static String creatingMCQPaper(int number, String topic, Diffculty diff) {
//     return 'Generate $number multiple-choice questions about $topic. '
//         'Difficulty: $diff. Format in JSON with fields: question, options, '
//         'correct_answer_index, difficulty';
//   }

//   static String creatingNormalPaper(int number, String topic, Diffculty diff) {
//     return """
// Generate an exam paper on '$topic'.
// Difficulty: $diff.
// Number of Questions: $number.
// Include:
// - Short Answer (4)
// - MCQ (2)
// - Medium Long (3)
// - Essay (1)

// Return valid JSON:
// {
//   "exam_paper": [
//     { "type": "short_answer", "question": "...", "answer": "..." },
//     { "type": "mcq", "question": "...", "options": ["..."], "answer_index": "..." },
//     { "type": "long_answer", "question": "...", "answer": "..." },
//     { "type": "essay", "question": "...", "answer": "..." }
//   ]
// }
// """;
//   }

//   static String creatingOneWordPaper(int number, String topic, Diffculty diff) {
//     return """
// Generate $number ONE-WORD questions on "$topic".
// Difficulty: $diff.

// Return output STRICTLY in the following JSON format:
// {
//   "one_word_paper": [
//     {
//       "question": "string",
//       "answer": "string"
//     }
//   ]
// }
// """;
//   }

//   static String creatingTASCPaper(int number, String topic, Diffculty diff) {
//     return 'Generate a TASC exam of $number questions about $topic. Difficulty: $diff. Output JSON.';
//   }

//   static String creatingUniversityException(
//     int number,
//     String topic,
//     Diffculty diff,
//   ) {
//     return 'Generate a university-style exam on $topic with $number questions. '
//         '1 question can be ignored (exception). Difficulty: $diff. Output JSON.';
//   }
// }
