import 'package:flutter/material.dart';
import '../main.dart';
import '../services/theme_service.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Mode"),
              subtitle: const Text(
                "Switch between Light and Dark theme",
              ),
              trailing: Switch(
                value: isDark,
                onChanged: (value) async {

  await CerebroPrepApp.of(context)
      ?.changeTheme(value);

  setState(() {
    isDark = value;
  });

},
              ),
            ),
          ),

        ],
      ),
    );
  }
}