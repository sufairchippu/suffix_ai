class QuestionModel {
  final String qestion;
  final String answer;
  QuestionModel({required this.answer, required this.qestion});
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      answer: json['answer']?.toString() ?? '',
      qestion: json['question']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'question': qestion, 'answer': answer};
  }
}

class ShortAnswerModel {
  final List<QuestionModel> questionModel;
  ShortAnswerModel({required this.questionModel});
  factory ShortAnswerModel.fromJson(Map<String, dynamic> json) {
    return ShortAnswerModel(
      questionModel: (json['one_word_paper'] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'one_word_paper': questionModel.map((e) => e.toJson())};
  }
}
