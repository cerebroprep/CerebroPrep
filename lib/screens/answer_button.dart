import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.only(bottom: 12.h),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
          ),
          onPressed: answered ? null : onTap,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}