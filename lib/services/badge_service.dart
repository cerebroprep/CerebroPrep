import '../models/badge.dart';

class BadgeService {
  static List<Badge> getBadges({
    required int xp,
    required int level,
    required int quizzes,
    required int streak,
    required int bestScore,
  }) {
    return [

      Badge(
        title: "First Quiz",
        description: "Complete your first quiz.",
        unlocked: quizzes >= 1,
        icon: "🎯",
      ),

      Badge(
        title: "Quiz Master",
        description: "Complete 10 quizzes.",
        unlocked: quizzes >= 10,
        icon: "📚",
      ),

      Badge(
        title: "Perfect Score",
        description: "Score 100% on a quiz.",
        unlocked: bestScore == 3,
        icon: "🏆",
      ),

      Badge(
        title: "Level 5",
        description: "Reach Level 5.",
        unlocked: level >= 5,
        icon: "⭐",
      ),

      Badge(
        title: "500 XP",
        description: "Earn 500 XP.",
        unlocked: xp >= 500,
        icon: "⚡",
      ),

      Badge(
        title: "7-Day Streak",
        description: "Maintain a 7-day streak.",
        unlocked: streak >= 7,
        icon: "🔥",
      ),

    ];
  }
}