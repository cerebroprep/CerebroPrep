import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/question.dart';
import '../services/gemini_service.dart';

import 'answer_button.dart';
import 'progress_widget.dart';
import 'question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String topic;
  final String difficulty;

  const QuizScreen({
    super.key,
    required this.topic,
    required this.difficulty,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];

  bool loading = true;
  String error = "";

  int currentQuestion = 0;
  int score = 0;

  int? selectedAnswer;
  List<int> userAnswers = [];

  bool answered = false;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    try {
      questions = await GeminiService.generateQuiz(
        widget.topic,
        widget.difficulty,
      );

      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Quiz Ready!"),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      userAnswers.add(index);

      if (index == questions[currentQuestion].correctAnswer) {
        score++;
      }
    });
  }

  Future<void> nextQuestion() async {
    if (!answered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please choose an answer first."),
        ),
      );
      return;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            topic: widget.topic,
            score: score,
            totalQuestions: questions.length,
            questions: questions,
            userAnswers: userAnswers,
          ),
        ),
      );

      if (result == true && mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),

                  SizedBox(height: 24.h),

                  Text(
                    "Generating AI Questions...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Our AI is creating your personalized quiz.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Quiz"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      ProgressWidget(
                        currentQuestion: currentQuestion + 1,
                        totalQuestions: questions.length,
                      ),

                      SizedBox(height: 20.h),

                      QuestionCard(
                        question: question.question,
                        currentQuestion: currentQuestion + 1,
                        totalQuestions: questions.length,
                      ),

                      SizedBox(height: 24.h),

                      ...List.generate(
                        question.options.length,
                        (index) {
                          return AnswerButton(
                            text: question.options[index],
                            isSelected: selectedAnswer == index,
                            isCorrect:
                                question.correctAnswer == index,
                            answered: answered,
                            onTap: () {
                              selectAnswer(index);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
                   
              SizedBox(height: 16.h),

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: answered ? nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    currentQuestion == questions.length - 1
                        ? "Finish Quiz"
                        : "Next",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}