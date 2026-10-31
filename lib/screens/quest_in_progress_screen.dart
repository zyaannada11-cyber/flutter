import 'package:flutter/material.dart';

class QuestInProgressScreen extends StatelessWidget {
  // Section D: Data passed through constructor
  final String userName;
  final String mode;
  final int level;

  const QuestInProgressScreen({
    super.key,
    required this.userName,
    required this.mode,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 40),
              const SizedBox(height: 10),
              const Text("Social Media",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text("Quest Level $level in Progress :",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text("Good luck, $userName!",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Mode: $mode", style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              const Text('"Strangers are just friends waiting to be met"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Quest Completed! +${100 * level} XP")),
                  );
                  Navigator.pop(context); // Section B: Navigator.pop
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("done and dusted",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
