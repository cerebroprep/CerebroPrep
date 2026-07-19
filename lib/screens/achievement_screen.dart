import 'package:flutter/material.dart';
import '../services/user_stats.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});
  

  @override
  State<AchievementScreen> createState() =>
      _AchievementScreenState();
}

class _AchievementScreenState
    extends State<AchievementScreen> {
      int quizzesCompleted = 0;
int level = 1;
int streak = 1;
int bestScore = 0;
@override
void initState() {
  super.initState();
  loadAchievements();
}
Future<void> loadAchievements() async {
  quizzesCompleted =
      await UserStats.getQuizzesCompleted();

  level =
      await UserStats.getLevel();

  streak =
      await UserStats.getStreak();

  bestScore =
      await UserStats.getBestScore();

  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:[

          AchievementTile(
            icon: Icons.emoji_events,
            title: "First Quiz",
            subtitle: "Complete your first quiz",
            unlocked: quizzesCompleted >= 1,
          ),

          AchievementTile(
            icon: Icons.workspace_premium,
            title: "Level 5",
            subtitle: "Reach Level 5",
            unlocked: level >= 5,
          ),

          AchievementTile(
            icon: Icons.star,
            title: "Perfect Score",
            subtitle: "Score 100%",
            unlocked: bestScore == 3,
          ),

          AchievementTile(
            icon: Icons.local_fire_department,
            title: "7-Day Streak",
            subtitle: "Study for 7 consecutive days",
            unlocked: streak >= 7,
          ),

          AchievementTile(
            icon: Icons.school,
            title: "Quiz Master",
            subtitle: "Complete 25 quizzes",
            unlocked: quizzesCompleted >= 25,
          ),
        ],
      ),
    );
  }
}

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool unlocked;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(
          icon,
          color: unlocked ? Colors.amber : Colors.grey,
          size: 40,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          unlocked
              ? Icons.check_circle
              : Icons.lock,
          color: unlocked
              ? Colors.green
              : Colors.grey,
        ),
      ),
    );
  }
}