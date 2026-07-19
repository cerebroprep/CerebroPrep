import 'package:flutter/material.dart';

import '../models/question.dart';
import '../services/gemini_service.dart';

import 'answer_button.dart';
import 'question_card.dart';
import 'progress_widget.dart';
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

    } 
    
    else {
      
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
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            CircularProgressIndicator(),

            SizedBox(height: 30),

            Text(
              "Generating AI Questions...",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Text(
              "Our AI is creating your personalized quiz.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

          ],
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(error),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ProgressWidget(
              currentQuestion: currentQuestion + 1,
              totalQuestions: questions.length,
            ),

            const SizedBox(height: 20),

            QuestionCard(
              question: question.question,
              currentQuestion: currentQuestion + 1,
              totalQuestions: questions.length,
            ),

            const SizedBox(height: 25),

            ...List.generate(question.options.length, (index) {

              return AnswerButton(

                text: question.options[index],

                isSelected: selectedAnswer == index,

                isCorrect: question.correctAnswer == index,

                answered: answered,

                onTap: () {
                  selectAnswer(index);
                },

              );

            }),

            const Spacer(),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: answered ? nextQuestion : null,
                child: Text(
                  currentQuestion == questions.length - 1
                      ? "Finish Quiz"
                      : "Next",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}