import 'package:flutter/material.dart';
import 'quiz_review_screen.dart';
import '../models/quiz_history.dart';
import '../services/user_stats.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String formatDate(String date) {
  final quizDate = DateTime.parse(date);
  final now = DateTime.now();

  final difference = now.difference(quizDate).inDays;

  if (difference == 0) {
    return "Today • ${DateFormat('h:mm a').format(quizDate)}";
  }

  if (difference == 1) {
    return "Yesterday • ${DateFormat('h:mm a').format(quizDate)}";
  }

  return DateFormat("dd MMM yyyy • h:mm a").format(quizDate);
}
  List<QuizHistory> history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    history = await UserStats.getQuizHistory();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz History"),
      ),
      body: history.isEmpty
          ? Center(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

        Icon(
          Icons.history,
          size: 90,
          color: Colors.grey,
        ),

        SizedBox(height: 20),

        Text(
          "No Quiz History Yet",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 12),

        Text(
          "Complete your first AI quiz to start tracking your progress.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),

      ],
    ),
  ),
)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final quiz = history[index];

                final percentage =
                    ((quiz.score / quiz.totalQuestions) * 100)
                        .toStringAsFixed(0);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => QuizReviewScreen(
        quiz: quiz,
      ),
    ),
  );
},
                    leading: const Icon(
                      Icons.history,
                      color: Colors.blue,
                    ),
                    title: Text(
                      quiz.topic,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Score: ${quiz.score}/${quiz.totalQuestions}\n${formatDate(quiz.date)}",
                    ),
                    trailing: Text(
                      "$percentage%",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}