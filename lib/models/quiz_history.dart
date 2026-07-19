import 'question_review.dart';

class QuizHistory {
  final String topic;
  final int score;
  final int totalQuestions;
  final String date;
  final List<QuestionReview> review;

  QuizHistory({
  required this.topic,
  required this.score,
  required this.totalQuestions,
  required this.date,
  required this.review,
});

  Map<String, dynamic> toJson() {
    return {
  "topic": topic,
  "score": score,
  "totalQuestions": totalQuestions,
  "date": date,
  "review": review
      .map((item) => item.toJson())
      .toList(),
};
  }

  factory QuizHistory.fromJson(
    Map<String, dynamic> json) {
  return QuizHistory(
    topic: json["topic"],
    score: json["score"],
    totalQuestions: json["totalQuestions"],
    date: json["date"],
    review: json["review"] == null
    ? []
    : (json["review"] as List)
        .map(
          (item) => QuestionReview.fromJson(item),
        )
        .toList(),
  );
}
}