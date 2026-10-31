import 'package:flutter/material.dart';
import 'quest_in_progress_screen.dart';

class QuestSelectionScreen extends StatefulWidget {
  // Section D: data received through constructor (from HomeScreen)
  final String initialMode;

  const QuestSelectionScreen({super.key, this.initialMode = "Solo Mode"});

  @override
  State<QuestSelectionScreen> createState() => _QuestSelectionScreenState();
}

class _QuestSelectionScreenState extends State<QuestSelectionScreen> {
  // Section C: TextEditingController
  final TextEditingController _nameController = TextEditingController();
  late String selectedMode;

  @override
  void initState() {
    super.initState();
    selectedMode = widget.initialMode;
  }

  @override
  void dispose() {
    // Section C: dispose controller
    _nameController.dispose();
    super.dispose();
  }

  void _startQuest(int level) {
    // Section C: empty input shows SnackBar
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name to start!")),
      );
      return;
    }

    // Section B: Navigator.push + Section D: Data passed via constructor
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestInProgressScreen(
          userName: _nameController.text.trim(),
          mode: selectedMode,
          level: level,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Section B: Navigator.pop
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Choose Your Path",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Section C: TextField
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Mode selection with setState
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => selectedMode = "Solo Mode"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMode == "Solo Mode"
                          ? Colors.white
                          : Colors.grey[300],
                    ),
                    child: const Text("Solo Mode",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        setState(() => selectedMode = "Friendship Mode"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMode == "Friendship Mode"
                          ? Colors.white
                          : Colors.grey[300],
                    ),
                    child: const Text("Friendship Mode",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text("SELECT A LEVEL",
                style: TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 10),

            // Section E: ListView.builder, tap a level to open its detail
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final level = index + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black12),
                      ),
                      title: Text("$level. Quest Level $level"),
                      trailing: Text("+${100 * level} XP"),
                      onTap: () => _startQuest(level),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _startQuest(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F483D),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Start Quest",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
