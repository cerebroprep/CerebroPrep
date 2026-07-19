class QuestionReview {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final int userAnswer;

  QuestionReview({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.userAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "options": options,
      "correctAnswer": correctAnswer,
      "userAnswer": userAnswer,
    };
  }

  factory QuestionReview.fromJson(
      Map<String, dynamic> json) {
    return QuestionReview(
      question: json["question"],
      options: List<String>.from(json["options"]),
      correctAnswer: json["correctAnswer"],
      userAnswer: json["userAnswer"],
    );
  }
}