import 'package:flutter/material.dart';
import '../services/user_stats.dart';
import '../models/quiz_history.dart';
import '../models/question_review.dart';
import '../models/question.dart';
import '../services/app_refresh.dart';

class ResultScreen extends StatefulWidget {
  final String topic;
  final int score;
  final int totalQuestions;
  final List<Question> questions;
final List<int> userAnswers;

  const ResultScreen({
  super.key,
  required this.topic,
  required this.score,
  required this.totalQuestions,
  required this.questions,
  required this.userAnswers,
});



@override
State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool saved = false;

@override
void initState() {
  super.initState();
  saveProgress();
}

Future<void> saveProgress() async {
  if (saved) return;

  saved = true;

  int xp = await UserStats.getXP();
  int level = await UserStats.getLevel();
  int quizzes = await UserStats.getQuizzesCompleted();
  int best = await UserStats.getBestScore();
  int streak = await UserStats.getStreak();

String lastQuizDate =
    await UserStats.getLastQuizDate();
    DateTime today = DateTime.now();


    if (lastQuizDate.isEmpty) {

  streak = 1;

} else {

  DateTime previous =
      DateTime.parse(lastQuizDate);

  int difference =
      today.difference(previous).inDays;

  if (difference == 1) {

    streak++;

  } else if (difference > 1) {

    streak = 1;

  }

}

  quizzes++;

  xp += widget.score * 10;
  String todayDate =
  
    today.toIso8601String().split("T")[0];

String savedDate =
    await UserStats.getDailyChallengeDate();

bool completed =
    await UserStats.isDailyChallengeCompleted();

if (savedDate != todayDate) {
  completed = false;

  await UserStats.setDailyChallengeCompleted(false);

  await UserStats.saveDailyChallengeDate(todayDate);
}

if (!completed) {
  xp += 50;

  await UserStats.setDailyChallengeCompleted(true);
}

  if (widget.score == widget.totalQuestions) {
    xp += 30;
  }

  level = (xp ~/ 100) + 1;

  if (widget.score > best) {
    best = widget.score;
  }
  await UserStats.saveStreak(streak);

await UserStats.saveLastQuizDate(
  today.toIso8601String(),
);

  await UserStats.saveXP(xp);
  await UserStats.saveLevel(level);
  await UserStats.saveBestScore(best);
  await UserStats.saveQuizzesCompleted(quizzes);
  List<QuestionReview> review = [];

for (int i = 0; i < widget.questions.length; i++) {
  review.add(
    QuestionReview(
      question: widget.questions[i].question,
      options: widget.questions[i].options,
      correctAnswer: widget.questions[i].correctAnswer,
      userAnswer: widget.userAnswers[i],
    ),
  );
}
  await UserStats.saveQuizHistory(
  QuizHistory(
  topic: widget.topic,
  score: widget.score,
  totalQuestions: widget.totalQuestions,
  date: DateTime.now().toString(),
  review: review,
),
);
AppRefresh.refresh();
}


  @override
  Widget build(BuildContext context) {
    final percentage = (widget.score/ widget.totalQuestions) * 100;

    String grade;
    String message;
    Color gradeColor;

    if (percentage >= 90) {
  grade = "A+";
  message = "🏆 Perfect Score!\nYou're unstoppable!";
  gradeColor = Colors.green;
} else if (percentage >= 75) {
  grade = "A";
  message = "🔥 Excellent!\nYou're getting really good.";
  gradeColor = Colors.lightGreen;
} else if (percentage >= 60) {
  grade = "B";
  message = "👏 Nice Work!\nJust a little more for an A.";
  gradeColor = Colors.orange;
} else {
  grade = "C";
  message = "💪 Every expert starts somewhere.\nTry another quiz!";
  gradeColor = Colors.red;
}

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Results"),
        centerTitle: true,
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 90,
          ),

          const SizedBox(height: 20),

          Text(
            message,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

              const SizedBox(height: 30),

              Text(
  "${widget.score} / ${widget.totalQuestions}",
  style: const TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
  ),
),
              const SizedBox(height: 20),

              Text(
                "${percentage.toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),

              const SizedBox(height: 30),

              CircleAvatar(
                radius: 40,
                backgroundColor: gradeColor,
                child: Text(
                  grade,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [

        const Text(
          "🎯 Next Goal",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        const Text(
  "Reach the next level",
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
),

        const SizedBox(height: 8),

        const Text(
          "Complete another quiz",
        ),

      ],
    ),
  ),
),
              const SizedBox(height: 40),
                 
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text("Back Home"),
                  onPressed: () {
  Navigator.pop(context, true);
},
                      ),
              ),
        ],
        ),
      ),
    ),
  ),
    );
}
}