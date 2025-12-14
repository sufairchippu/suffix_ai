class McqQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String difficulty;

  McqQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.difficulty,
  });

  factory McqQuestion.fromJson(Map<String, dynamic> json) {
    return McqQuestion(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswerIndex: json['correct_answer_index'] ?? 0,
      difficulty: json['difficulty'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_answer_index': correctAnswerIndex,
      'difficulty': difficulty,
    };
  }
}
