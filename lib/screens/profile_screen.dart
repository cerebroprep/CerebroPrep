import 'package:flutter/material.dart';
import '../services/user_stats.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int xp = 0;
  int level = 1;
  int streak = 1;
  int quizzes = 0;
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    xp = await UserStats.getXP();
    level = await UserStats.getLevel();
    streak = await UserStats.getStreak();
    quizzes = await UserStats.getQuizzesCompleted();
    bestScore = await UserStats.getBestScore();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body:SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [

        const CircleAvatar(
          radius: 55,
          child: Icon(
            Icons.person,
            size: 60,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "CerebroPrep User",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Keep learning every day 🚀",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        
       Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [

        ListTile(
          leading: const Icon(Icons.star),
          title: const Text("Level"),
          trailing: Text(level.toString()),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.flash_on),
          title: const Text("XP"),
          trailing: Text("$xp XP"),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.quiz),
          title: const Text("Quizzes Completed"),
          trailing: Text(quizzes.toString()),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.emoji_events),
          title: const Text("Best Score"),
          trailing: Text(bestScore.toString()),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.local_fire_department),
          title: const Text("Current Streak"),
          trailing: Text("$streak Day(s)"),
        ),

      ],
    ),
  ),
),
const SizedBox(height: 30),

      ],
    ),
  ),
)
    );
  }
}