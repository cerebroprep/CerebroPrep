import 'package:flutter/material.dart';
import '../services/user_stats.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int level = 1;
  int xp = 0;
  int quizzesCompleted = 0;
  int bestScore = 0;
  int streak = 1;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    level = await UserStats.getLevel();
    xp = await UserStats.getXP();
    quizzesCompleted = await UserStats.getQuizzesCompleted();
    bestScore = await UserStats.getBestScore();
    streak = await UserStats.getStreak();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int currentLevelXP = (level - 1) * 100;

int nextLevelXP = level * 100;

double progress =
    (xp - currentLevelXP) /
    (nextLevelXP - currentLevelXP);

int xpRemaining = nextLevelXP - xp;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            Card(
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [

        Text(
          "Level $level",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        LinearProgressIndicator(
          value: progress,
          minHeight: 12,
          borderRadius: BorderRadius.circular(10),
        ),

        const SizedBox(height: 15),

        Text(
          "$xp / $nextLevelXP XP",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "$xpRemaining XP until Level ${level + 1}",
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

      ],
    ),
  ),
),
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [

        const Icon(
          Icons.local_fire_department,
          color: Colors.orange,
          size: 50,
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Daily Streak",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "$streak Day${streak == 1 ? "" : "s"} 🔥",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Keep learning every day!",
                style: TextStyle(
                  color: Colors.grey,
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

            Text(
              "XP: $xp",
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            Text(
              "Quizzes Completed: $quizzesCompleted",
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            Text(
              "Best Score: $bestScore",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}