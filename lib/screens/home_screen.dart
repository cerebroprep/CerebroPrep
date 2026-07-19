import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'progress_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';
import '../widgets/menu_button.dart';
import 'achievement_screen.dart';
import '../widgets/daily_challenge_card.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'analytics_screen.dart';
import '../services/app_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController topicController = TextEditingController();

  String selectedDifficulty = 'Easy';
   bool loading = false;
   String greeting = "";
   void setGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    greeting = "🌅 Good Morning";
  } else if (hour < 17) {
    greeting = "☀️ Good Afternoon";
  } else {
    greeting = "🌙 Good Evening";
  }
}@override
void initState() {
  super.initState();
  setGreeting();
  AppRefresh.refreshNotifier.addListener(refreshHome);
}
void refreshHome() {
  if (mounted) {
    setState(() {});
  }
}
@override
void dispose() {
  AppRefresh.refreshNotifier.removeListener(refreshHome);
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CerebroPrep"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Image.asset(
  'assets/branding/logo.png',
  height: 170,
),

const SizedBox(height: 20),

            Text(
  "$greeting 👋",
  style: const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
),

            const SizedBox(height: 10),

            const Text(
              "Study smarter. Practice faster. Score higher.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            DailyChallengeCard(
  key: ValueKey(AppRefresh.refreshNotifier.value),
),

const SizedBox(height: 30),

            TextField(
              controller: topicController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Topic',
                hintText: 'Example: Photosynthesis',
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: selectedDifficulty,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Difficulty',
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Easy',
                  child: Text('Easy'),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: 'Hard',
                  child: Text('Hard'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: loading
    ? null
    : () async {

  if (topicController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.orange.shade700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: const Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            "Please enter a topic.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 2),
  ),
);

    return;
  }
                  setState(() {
                   loading = true;
                  });

                await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => QuizScreen(
      topic: topicController.text.trim(),
      difficulty: selectedDifficulty,
    ),
  ),
);

topicController.clear();

setState(() {
  loading = false;
});
                },
                child: loading
    ? const CircularProgressIndicator(
        color: Colors.white,
      )
    : const Text("Generate Quiz"),
              ),
            ),

            const SizedBox(height: 15),

            MenuButton(
  text: "View Progress",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProgressScreen(),
      ),
    );
  },
),

MenuButton(
  text: "Quiz History",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
      ),
    );
  },
),
MenuButton(
  text: "Achievements",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AchievementScreen(),
      ),
    );
  },
),
const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    },
    child: const Text("Profile"),
  ),
),
const SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  height: 55,
  child: OutlinedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AnalyticsScreen(),
        ),
      );
    },
    child: const Text("Analytics"),
  ),
),
const SizedBox(height: 15),


SizedBox(
  width: double.infinity,
  height: 55,
  child: OutlinedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        ),
      );
    },
    child: const Text("Settings"),
  ),
),
const SizedBox(height: 15),
MenuButton(
  text: "About",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AboutScreen(),
      ),
    );
  },
),
    
  
          ],
        ),
      ),
    );
  }
}