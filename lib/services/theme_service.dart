import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String themeKey = "isDarkMode";

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(themeKey) ?? false;
  }

  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(themeKey, isDark);
  }
}