import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quiz_history.dart';

class UserStats {
  static const String xpKey = "xp";
  static const String levelKey = "level";
  static const String bestScoreKey = "bestScore";
  static const String quizzesKey = "quizzesCompleted";
  static const String historyKey = "quizHistory";
  static int streak = 1;
static String lastQuizDate = "";
static const String streakKey = "streak";
static const String lastQuizDateKey = "lastQuizDate";
static const String dailyChallengeCompletedKey =
    "dailyChallengeCompleted";

static const String dailyChallengeDateKey =
    "dailyChallengeDate";

  // XP
  static Future<int> getStreak() async {
  final prefs = await SharedPreferences.getInstance();

  streak = prefs.getInt(streakKey) ?? 1;

  return streak;
}
static Future<String> getLastQuizDate() async {
  final prefs = await SharedPreferences.getInstance();

  lastQuizDate =
      prefs.getString(lastQuizDateKey) ?? "";

  return lastQuizDate;
}
static Future<void> saveStreak(int value) async {
  final prefs = await SharedPreferences.getInstance();

  streak = value;

  await prefs.setInt(streakKey, value);
}
static Future<void> saveLastQuizDate(String value) async {
  final prefs = await SharedPreferences.getInstance();

  lastQuizDate = value;

  await prefs.setString(
    lastQuizDateKey,
    value,
  );
}
static Future<String> getDailyChallengeDate() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString(
        dailyChallengeDateKey,
      ) ??
      "";
}

static Future<void> saveDailyChallengeDate(
    String date) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    dailyChallengeDateKey,
    date,
  );
}
  static Future<int> getXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }

  static Future<void> saveXP(int xp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(xpKey, xp);
  }

  // Level
  static Future<int> getLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(levelKey) ?? 1;
  }

  static Future<void> saveLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(levelKey, level);
  }

  // Best Score
  static Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(bestScoreKey) ?? 0;
  }

  static Future<void> saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(bestScoreKey, score);
  }

  // Quizzes Completed
  static Future<int> getQuizzesCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(quizzesKey) ?? 0;
  }

  static Future<void> saveQuizzesCompleted(int quizzes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(quizzesKey, quizzes);
  }
  // Save one quiz attempt
static Future<void> saveQuizHistory(QuizHistory history) async {
  final prefs = await SharedPreferences.getInstance();

  final List<String> historyList =
      prefs.getStringList(historyKey) ?? [];

  historyList.add(jsonEncode(history.toJson()));

await prefs.setStringList(historyKey, historyList);

}

// Read all quiz attempts
static Future<List<QuizHistory>> getQuizHistory() async {
  final prefs = await SharedPreferences.getInstance();

  final List<String> historyList =
      prefs.getStringList(historyKey) ?? [];
      

  return historyList
      .map(
        (item) => QuizHistory.fromJson(
          jsonDecode(item),
        ),
      )
      .toList();
      
}
static Future<bool> isDailyChallengeCompleted() async {
  final prefs = await SharedPreferences.getInstance();

  final completed =
      prefs.getBool(dailyChallengeCompletedKey) ?? false;

  if (!completed) {
    return false;
  }

  final completedDate =
      prefs.getString(dailyChallengeDateKey);

  if (completedDate == null || completedDate.isEmpty) {
    return false;
  }

  final completedTime =
      DateTime.tryParse(completedDate);

  if (completedTime == null) {
    return false;
  }

  final now = DateTime.now();

  final difference =
      now.difference(completedTime);

  if (difference.inHours >= 24) {
    await prefs.setBool(
      dailyChallengeCompletedKey,
      false,
    );

    return false;
  }

  return true;
}

static Future<void> setDailyChallengeCompleted(
    bool value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool(
    dailyChallengeCompletedKey,
    value,
  );

  if (value) {
    await prefs.setString(
      dailyChallengeDateKey,
      DateTime.now().toIso8601String(),
    );
  } else {
    await prefs.remove(
      dailyChallengeDateKey,
    );
  }
}
}