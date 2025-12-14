class TascPapperModel {
  final List<TascQuestionModel> tasqPapper;
  TascPapperModel({required this.tasqPapper});
  factory TascPapperModel.fromJson(Map<String, dynamic> json) {
    return TascPapperModel(tasqPapper: json['tasc_paper']);
  }
  Map<String, dynamic> toJson() {
    return {'tasc_paper': tasqPapper.map((e) => e.toJson())};
  }
}

class TascQuestionModel {
  final String question;
  final String description;
  final String answer;
  TascQuestionModel({
    required this.answer,
    required this.description,
    required this.question,
  });
  factory TascQuestionModel.fromjson(Map<String, dynamic> json) {
    return TascQuestionModel(
      answer: json['answer'],
      description: json['description'],
      question: json['question'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'question': question, 'description': description, 'answer': answer};
  }
}
