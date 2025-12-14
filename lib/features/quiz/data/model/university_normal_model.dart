class UniversityTypeModel {
  List<ExamPaper>? examPaper;

  UniversityTypeModel({this.examPaper});

  UniversityTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['exam_paper'] != null) {
      examPaper = <ExamPaper>[];
      json['exam_paper'].forEach((v) {
        examPaper!.add(ExamPaper.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examPaper != null) {
      data['exam_paper'] = examPaper!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamPaper {
  String? type;
  String? question;
  String? answer;
  List<String>? options;
  String? answerIndex;

  ExamPaper({
    this.type,
    this.question,
    this.answer,
    this.options,
    this.answerIndex,
  });

  ExamPaper.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    question = json['question'];
    answer = json['answer'];
    options = json['options'] as List<String>;
    answerIndex = json['answer_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['question'] = question;
    data['answer'] = answer;
    data['options'] = options;
    data['answer_index'] = answerIndex;
    return data;
  }
}





// To parse this JSON data, do
//
//     final universityTypeModel = universityTypeModelFromJson(jsonString);

// import 'dart:convert';

// UniversityTypeModel universityTypeModelFromJson(String str) => UniversityTypeModel.fromJson(json.decode(str));

// String universityTypeModelToJson(UniversityTypeModel data) => json.encode(data.toJson());

// class UniversityTypeModel {
//     List<ExamPaper> examPaper;

//     UniversityTypeModel({
//         required this.examPaper,
//     });

//     factory UniversityTypeModel.fromJson(Map<String, dynamic> json) => UniversityTypeModel(
//         examPaper: List<ExamPaper>.from(json["exam_paper"].map((x) => ExamPaper.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "exam_paper": List<dynamic>.from(examPaper.map((x) => x.toJson())),
//     };
// }

// class ExamPaper {
//     Type type;
//     String question;
//     String? answer;
//     List<String>? options;
//     String? answerIndex;

//     ExamPaper({
//         required this.type,
//         required this.question,
//         this.answer,
//         this.options,
//         this.answerIndex,
//     });

//     factory ExamPaper.fromJson(Map<String, dynamic> json) => ExamPaper(
//         type: typeValues.map[json["type"]]!,
//         question: json["question"],
//         answer: json["answer"],
//         options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
//         answerIndex: json["answer_index"],
//     );

//     Map<String, dynamic> toJson() => {
//         "type": typeValues.reverse[type],
//         "question": question,
//         "answer": answer,
//         "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
//         "answer_index": answerIndex,
//     };
// }

// enum Type {
//     ESSAY,
//     LONG_ANSWER,
//     MCQ,
//     SHORT_ANSWER
// }

// final typeValues = EnumValues({
//     "essay": Type.ESSAY,
//     "long_answer": Type.LONG_ANSWER,
//     "mcq": Type.MCQ,
//     "short_answer": Type.SHORT_ANSWER
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//             reverseMap = map.map((k, v) => MapEntry(v, k));
//             return reverseMap;
//     }
// }
