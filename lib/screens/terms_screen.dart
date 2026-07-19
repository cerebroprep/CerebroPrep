import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Terms & Conditions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            Text(
              "Welcome to CerebroPrep. By using this application, you agree to the following terms.",
              style: TextStyle(fontSize: 17),
            ),

            SizedBox(height: 25),

            Text(
              "Acceptable Use",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Use CerebroPrep for educational purposes only. Do not misuse or attempt to interfere with the application's normal operation.",
            ),

            SizedBox(height: 25),

            Text(
              "AI Generated Content",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Quiz questions are generated using AI. While we strive for accuracy, occasional mistakes or variations may occur.",
            ),

            SizedBox(height: 25),

            Text(
              "Limitation of Liability",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "CerebroPrep is provided 'as is' without warranties. We are not responsible for any loss resulting from the use of this application.",
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                "Effective: July 2026",
                style: TextStyle(color: Colors.grey),
              ),
            ),

          ],
        ),
      ),
    );
  }
}