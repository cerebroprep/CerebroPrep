import 'package:flutter/material.dart';
import '../services/user_stats.dart';


class DailyChallengeCard extends StatefulWidget {
  const DailyChallengeCard({super.key});

  @override
  State<DailyChallengeCard> createState() =>
      _DailyChallengeCardState();
}
class _DailyChallengeCardState
    extends State<DailyChallengeCard> {
      bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                ),

                SizedBox(width: 10),

                Text(
                  "Daily Challenge",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            SizedBox(height: 20),

            Text(
              completed
    ? "Today's challenge completed!"
    : "Complete one AI Quiz today",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            SizedBox(height: 15),

            LinearProgressIndicator(
              value: completed ? 1 : 0,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Reward",
                ),

                Text(
                  completed
    ? "Reward Claimed"
    : "+50 XP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

      
      @override
void initState() {
  super.initState();
  loadChallenge();
}
Future<void> loadChallenge() async {
  completed =
      await UserStats.isDailyChallengeCompleted();

  setState(() {});
}
    }
  
