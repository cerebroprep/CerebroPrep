import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10.h,
          ),
        ),

        SizedBox(height: 10.h),

        Text(
          "${(progress * 100).toInt()}% Completed",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}