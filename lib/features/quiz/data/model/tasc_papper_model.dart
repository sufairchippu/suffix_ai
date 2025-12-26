class TascPapperModel {
  final String type;
  final List<TascQuestionModel> tasqPapper;
  TascPapperModel({required this.tasqPapper, required this.type});
  factory TascPapperModel.fromJson(Map<String, dynamic> json) {
    return TascPapperModel(
      type: json['type'] as String,
      tasqPapper: (json['questions'] as List<dynamic>)
          .map((e) => TascQuestionModel.fromjson(e as Map<String,dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'questions': tasqPapper.map((e) => e.toJson()).toList(),
    };
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
