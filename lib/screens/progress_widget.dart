import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const ProgressWidget({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentQuestion / totalQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          borderRadius: BorderRadius.circular(12),
        ),

        const SizedBox(height: 8),

        Text(
          "${(progress * 100).toInt()}% Completed",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}