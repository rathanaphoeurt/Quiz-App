class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  int? selectedOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    this.selectedOptionIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'selectedOptionIndex': selectedOptionIndex,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
      selectedOptionIndex: json['selectedOptionIndex'],
    );
  }
}
