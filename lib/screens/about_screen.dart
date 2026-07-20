import 'package:flutter/material.dart';
import 'contact_screen.dart';
import 'privacy_screen.dart';
import 'terms_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About CerebroPrep"),
      ),
      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(25),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 20),

            Image.asset(
  'assets/branding/logo.png',
  height: 160,
),
const SizedBox(height: 15),

const Text(
  "Study smarter. Practice faster. Score higher.",
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
  ),
),

const SizedBox(height: 25),

            const SizedBox(height: 20),

            const Text(
              "CerebroPrep",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "AI-powered quizzes designed to help you learn,\n"
              "practice and track your progress every day.",
              textAlign: TextAlign.center,
            ),

            const Divider(height: 40),

            const ListTile(
              leading: Icon(Icons.verified),
              title: Text("Version"),
              subtitle: Text("1.0.0"),
            ),

            const ListTile(
              leading: Icon(Icons.smart_toy),
              title: Text("Powered By"),
              subtitle: Text("Powered by Gemini"),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Developer"),
              subtitle: Text("CerebroPrep"),
            ),
            const Divider(height: 40),

ListTile(
  leading: const Icon(Icons.contact_mail),
  title: const Text("Contact Us"),
  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ContactScreen(),
      ),
    );
  },
),

ListTile(
  leading: const Icon(Icons.privacy_tip),
  title: const Text("Privacy Policy"),
  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PrivacyScreen(),
      ),
    );
  },
),

ListTile(
  leading: const Icon(Icons.gavel),
  title: const Text("Terms & Conditions"),
  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TermsScreen(),
      ),
    );
  },
),

            const SizedBox(height: 40),

            const Text(
  "Built with Flutter & Google Gemini AI\n\n"
  "Thank you for choosing CerebroPrep.\n"
  "We're committed to making learning smarter with AI.\n\n"
  "© 2026 CerebroPrep\n"
  "All rights reserved.",
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.grey,
    height: 1.5,
  ),
),
            

            const SizedBox(height: 20),
          ],
        ),
      ),
      ),
    );
  }
}