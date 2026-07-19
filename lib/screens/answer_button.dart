import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool answered;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color foregroundColor = Colors.black;

    if (answered) {
      if (isCorrect) {
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
      } else if (isSelected) {
        backgroundColor = Colors.red;
        foregroundColor = Colors.white;
      }
    } else if (isSelected) {
      backgroundColor = Colors.blue;
      foregroundColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),

          // 👇 IMPORTANT CHANGE
          onPressed: () {
            if (!answered) {
              onTap();
            }
          },

          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}