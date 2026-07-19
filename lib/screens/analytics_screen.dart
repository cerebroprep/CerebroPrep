import 'package:flutter/material.dart' hide Badge;
import '../services/user_stats.dart';
import '../models/quiz_history.dart';
import 'package:fl_chart/fl_chart.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() =>
      _AnalyticsScreenState();
}

class _AnalyticsScreenState
    extends State<AnalyticsScreen> {
int xp = 0;
int level = 1;
int quizzes = 0;
int streak = 1;
int bestScore = 0;
List<QuizHistory> history = [];


Map<String, int> topicCount = {};
Map<String, int> topicCorrect = {};

Map<String, int> topicAttempted = {};
String weakestTopic = "";
double weakestAccuracy = 100;
String motivation = "";
String strongestTopic = "";
double strongestAccuracy = 0;
String performanceTitle = "";
String performanceMessage = "";
Color performanceColor = Colors.green;
String nextGoalTitle = "";
String nextGoalMessage = "";
@override
void initState() {
  super.initState();
  loadStats();
}

Future<void> loadStats() async {
  xp = await UserStats.getXP();
  level = await UserStats.getLevel();
  quizzes =
      await UserStats.getQuizzesCompleted();
  streak = await UserStats.getStreak();
  bestScore =
      await UserStats.getBestScore();
      history = await UserStats.getQuizHistory();



topicCount.clear();
topicCorrect.clear();
topicAttempted.clear();

for (var quiz in history) {

  topicCount[quiz.topic] =
      (topicCount[quiz.topic] ?? 0) + 1;

  topicCorrect[quiz.topic] =
      (topicCorrect[quiz.topic] ?? 0)
          + quiz.score;

  topicAttempted[quiz.topic] =
      (topicAttempted[quiz.topic] ?? 0)
          + quiz.totalQuestions;
}
weakestTopic = "";

weakestAccuracy = 100;
strongestTopic = "";
strongestAccuracy = 0;

topicCorrect.forEach((topic, correct) {
  final attempted = topicAttempted[topic] ?? 1;

  final accuracy =
      (correct / attempted) * 100;

  if (accuracy < weakestAccuracy) {
    weakestAccuracy = accuracy;
    weakestTopic = topic;
  }
});
topicCorrect.forEach((topic, correct) {
  final attempted = topicAttempted[topic] ?? 1;

  final accuracy =
      (correct / attempted) * 100;

  if (accuracy > strongestAccuracy) {
    strongestAccuracy = accuracy;
    strongestTopic = topic;
  }
});
if (quizzes == 0) {
  motivation =
      "🚀 Your learning journey starts today. Complete your first quiz!";
}
else if (streak >= 7) {
  motivation =
      "🔥 Incredible! A $streak-day streak shows real dedication.";
}
else if (bestScore == 3) {
  motivation =
      "⭐ Awesome! You're capable of perfect quiz scores.";
}
else if (level >= 5) {
  motivation =
      "🎯 Level $level achieved! Keep climbing higher.";
}
else {
  motivation =
      "💪 Every quiz makes you stronger. Keep learning every day.";
}
if (quizzes == 0) {
  performanceTitle = "Let's Begin!";
  performanceMessage =
      "Complete your first quiz to receive your performance rating.";
  performanceColor = Colors.grey;
}
else if (quizzes >= 5 && strongestAccuracy >= 90) {
  performanceTitle = "Excellent";
  performanceMessage =
      "You're mastering your quizzes. Keep up the fantastic work!";
  performanceColor = Colors.green;
}
else if (quizzes >= 3 && strongestAccuracy >= 70) {
  performanceTitle = "Good Progress";
  performanceMessage =
      "You're learning well. Keep practicing to reach mastery.";
  performanceColor = Colors.orange;
}
else {
  performanceTitle = "Needs Practice";
  performanceMessage =
      "Keep completing quizzes. Your performance rating will become more accurate as you practice.";
  performanceColor = Colors.red;
}
   if (quizzes < 3) {

  nextGoalTitle = "Complete 3 Quizzes";

  nextGoalMessage =
      "${3 - quizzes} more quiz${3 - quizzes == 1 ? "" : "zes"} to unlock better performance insights.";

}
else if (level < 5) {

  final remainingXP =
      (level * 100) - xp;

  nextGoalTitle = "Reach Level ${level + 1}";

  nextGoalMessage =
      "$remainingXP XP remaining.";

}
else if (streak < 7) {

  nextGoalTitle = "Build Your Streak";

  nextGoalMessage =
      "${7 - streak} more day${7 - streak == 1 ? "" : "s"} to reach a 7-day streak.";

}
else {

  nextGoalTitle = "Keep Improving";

  nextGoalMessage =
      "Challenge yourself with new quiz topics every day.";

}

  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
    child: Column(
    children: [

      Card(
        child: ListTile(
          leading: const Icon(Icons.bolt),
          title: const Text("Total XP"),
          trailing: Text("$xp XP"),
        ),
      ),

      Card(
        child: ListTile(
          leading: const Icon(Icons.star),
          title: const Text("Current Level"),
          trailing: Text(level.toString()),
        ),
      ),

      Card(
        child: ListTile(
          leading: const Icon(Icons.quiz),
          title: const Text("Quizzes Completed"),
          trailing: Text(quizzes.toString()),
        ),
      ),

      Card(
        child: ListTile(
          leading: const Icon(
              Icons.local_fire_department),
          title: const Text("Current Streak"),
          trailing: Text("$streak Day(s)"),
        ),
      ),

      Card(
        child: ListTile(
          leading: const Icon(Icons.emoji_events),
          title: const Text("Best Score"),
          trailing: Text(bestScore.toString()),
        ),
      ),
      const SizedBox(height: 30),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Topic Performance",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),
const SizedBox(height: 30),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Quiz Summary",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 30),


Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Performance Summary",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
const SizedBox(height: 20),

Card(
  color: performanceColor.withValues(alpha: 0.1),
  child: Padding(
    padding: const EdgeInsets.all(18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Icon(
          Icons.analytics,
          color: performanceColor,
          size: 34,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                performanceTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: performanceColor,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                performanceMessage,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  ),
),

const SizedBox(height: 25),
Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            const Icon(
              Icons.workspace_premium,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
            child: Text(
              "Your Strongest Topic",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        if (strongestTopic.isEmpty)

          const Text(
            "Complete quizzes to discover your strongest subject.",
          )

        else ...[

          Text(
            strongestTopic,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Accuracy: ${strongestAccuracy.toStringAsFixed(0)}%",
          ),

          const SizedBox(height: 10),

          const Text(
            "Fantastic work! Keep mastering this topic.",
          ),

        ],

      ],
    ),
  ),
),

const SizedBox(height: 20),
Text(
  "You've completed $quizzes quiz${quizzes == 1 ? '' : 'zes'} and earned $xp XP.",
),

const SizedBox(height: 10),

Text(
  "Current Level: $level",
),

const SizedBox(height: 10),

Text(
  "Best Score: $bestScore / 3",
),

const SizedBox(height: 10),

Text(
  streak == 1
      ? "Keep going! You're on a 1-day streak."
      : "Amazing! You're on a $streak-day streak!",
),
const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Quiz Performance History",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),
const SizedBox(height: 15),

const SizedBox(height: 20),
if (history.isEmpty)
  Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: const [
          Icon(
            Icons.insights,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "Performance Graph",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Complete a few quizzes to unlock your performance graph.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  )
else
  SizedBox(
    height: 250,
    child: BarChart(
      BarChartData(
        maxY: 100,
        alignment: BarChartAlignment.spaceAround,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              interval: 20,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text("Q${value.toInt() + 1}");
              },
            ),
          ),
        ),
        barGroups: List.generate(
          history.length,
          (index) {
            final quiz = history[index];
            final percentage =
                (quiz.score / quiz.totalQuestions) * 100;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: percentage,
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          },
        ),
      ),
    ),
  ),


const SizedBox(height: 15),
...topicCount.entries.map(
  (entry) => Card(
    child: ListTile(
      leading: const Icon(Icons.bar_chart),
      title: Text(entry.key),
      trailing: Text(
        "${entry.value} ${entry.value == 1 ? "Quiz" : "Quizzes"}"
      ),
    ),
  ),
),
const SizedBox(height: 30),

Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
  children: [
    const Icon(
      Icons.school,
      color: Colors.orange,
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Text(
        "Study Recommendation",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

        const SizedBox(height: 20),

        if (weakestTopic.isEmpty)

          const Text(
            "Complete more quizzes to receive personalized recommendations.",
          )

        else ...[

          Text(
            "Focus on: $weakestTopic",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Current Accuracy: ${weakestAccuracy.toStringAsFixed(0)}%",
          ),

          const SizedBox(height: 10),

          const Text(
            "Recommendation:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

         SizedBox(
  width: double.infinity,
  child: Text(
    "Practice more quizzes on $weakestTopic to strengthen your understanding.",
    softWrap: true,
  ),
),

        ],

      ],
    ),
  ),
),
Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Row(
          children: [
            Icon(
              Icons.flag,
              color: Colors.deepPurple,
            ),
            SizedBox(width: 10),
            Text(
              "Next Goal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Text(
          nextGoalTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          nextGoalMessage,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

      ],
    ),
  ),
),

const SizedBox(height: 25),
  const SizedBox(height: 25),

Card(
  color: Theme.of(context).cardColor,
  child: Padding(
    padding: const EdgeInsets.all(18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Icon(
          Icons.lightbulb,
          color: Colors.blue,
          size: 34,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Today's Motivation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                motivation,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

            ],
          ),
        ),

      ],
    ),
  ),
),
    ],
  ),
      ),
),
     ]
   
  )
    
 )  
       ) );
         
  }
}