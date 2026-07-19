import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const SizedBox(height: 10),

          const Icon(
            Icons.support_agent,
            size: 80,
            color: Colors.blue,
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "We're here to help!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              "If you have questions, suggestions or find a bug,\nfeel free to contact us.",
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: const Text(
                "cerebroprep.ai@gmail.com",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Send Feedback"),
              subtitle: const Text(
                "Help us improve CerebroPrep",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text("Report a Bug"),
              subtitle: const Text(
                "Found something wrong? Let us know.",
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.star),
              title: const Text("Rate CerebroPrep"),
              subtitle: const Text(
                "Coming after Play Store launch",
              ),
            ),
          ),

        ],
      ),
    );
  }
}