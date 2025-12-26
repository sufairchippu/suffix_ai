// // class QuestionPaperModel {
// //   final
// // }
// class UniversityRootModel {
//   final UniversityPaperModel universityPaper;

//   UniversityRootModel({required this.universityPaper});

//   factory UniversityRootModel.fromJson(Map<String, dynamic> json) {
//     return UniversityRootModel(
//       universityPaper: UniversityPaperModel.fromJson(json['university_paper']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"university_paper": universityPaper.toJson()};
//   }
// }

// class UniversityPaperModel {
//   final int ignoreQuestionCount;
//   final List<QuestionItem> questions;

//   UniversityPaperModel({
//     required this.ignoreQuestionCount,
//     required this.questions,
//   });

//   factory UniversityPaperModel.fromJson(Map<String, dynamic> json) {
//     return UniversityPaperModel(
//       ignoreQuestionCount: json['ignore_question_count'],
//       questions: (json['questions'] as List)
//           .map((e) => QuestionItem.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "ignore_question_count": ignoreQuestionCount,
//       "questions": questions.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class QuestionItem {
//   final String question;
//   final int marks;
//   final String answer;

//   QuestionItem({
//     required this.question,
//     required this.marks,
//     required this.answer,
//   });

//   factory QuestionItem.fromJson(Map<String, dynamic> json) {
//     return QuestionItem(
//       question: json['question'],
//       marks: json['marks'],
//       answer: json['answer'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"question": question, "marks": marks, "answer": answer};
//   }
// }
