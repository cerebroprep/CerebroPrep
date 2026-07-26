import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final int currentQuestion;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.question,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question $currentQuestion of $totalQuestions",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              question,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}