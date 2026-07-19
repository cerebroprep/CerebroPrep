import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            Text(
              "CerebroPrep respects your privacy and is committed to protecting your personal information.",
              style: TextStyle(fontSize: 17),
            ),

            SizedBox(height: 20),

            Text(
              "Information We Store",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "• Quiz history\n"
              "• XP and Level progress\n"
              "• Achievements\n"
              "• Daily streak information",
            ),

            SizedBox(height: 25),

            Text(
              "AI Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Quiz questions are generated using Google Gemini AI. We do not sell or share your personal information.",
            ),

            SizedBox(height: 25),

            Text(
              "Data Storage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Your progress is stored locally on your device. Future versions may introduce optional cloud backup.",
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                "Last Updated: July 2026",
                style: TextStyle(color: Colors.grey),
              ),
            ),

          ],
        ),
      ),
    );
  }
}