import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/theme_service.dart';
import 'theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const CerebroPrepApp());
}


class CerebroPrepApp extends StatefulWidget {
  const CerebroPrepApp({super.key});

  static CerebroPrepAppState? of(BuildContext context) {
  return context.findAncestorStateOfType<CerebroPrepAppState>();
}

  @override
  State<CerebroPrepApp> createState() => CerebroPrepAppState();
}

class CerebroPrepAppState extends State<CerebroPrepApp> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    isDark = await ThemeService.getTheme();
    setState(() {});
  }

  Future<void> changeTheme(bool value) async {
    await ThemeService.saveTheme(value);

    setState(() {
      isDark = value;
    });
  }

  @override
Widget build(BuildContext context) {
  return ScreenUtilInit(
    designSize: const Size(393, 852), // Your Pixel 9 reference size
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CerebroPrep',

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        themeMode: isDark
            ? ThemeMode.dark
            : ThemeMode.light,

        home: const HomeScreen(),
      );
    },
  );
}
}