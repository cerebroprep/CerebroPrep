import 'package:flutter/material.dart';
import '../models/quiz_history.dart';

class QuizReviewScreen extends StatelessWidget {
  final QuizHistory quiz;

  const QuizReviewScreen({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Review"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: quiz.review.length,
        itemBuilder: (context, index) {
          final question = quiz.review[index];

          final bool correct =
              question.userAnswer ==
                  question.correctAnswer;

          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    "Question ${index + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Your Answer",
                    style: TextStyle(
                      color: correct
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    question.options[
                        question.userAnswer],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Correct Answer",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    question.options[
                        question.correctAnswer],
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}