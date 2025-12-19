class McqPaperModel {
  final String type;
  final List<McqQuestionModel> questions;

  McqPaperModel({required this.type, required this.questions});

  factory McqPaperModel.fromJson(Map<String, dynamic> json) {
    return McqPaperModel(
      type: json['type'] ?? 'mcq',
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((e) => McqQuestionModel.fromJson(e))
          .toList(),
    );
  }
}

class McqQuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  McqQuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory McqQuestionModel.fromJson(Map<String, dynamic> json) {
    return McqQuestionModel(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correct_index'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_index': correctIndex,
    };
  }
}
