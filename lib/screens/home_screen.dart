import 'package:flutter/material.dart';
import 'quest_selection_screen.dart';
import 'blocked_apps_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Section D: StatefulWidget + setState
  bool isSoloMode = true;
  int points = 980;

  String get currentMode => isSoloMode ? "Solo Mode" : "Friendship Mode";

  void _openQuestSelection() {
    // Section D: data passed through constructor
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestSelectionScreen(initialMode: currentMode),
      ),
    );
  }

  void _openBlockedApps() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BlockedAppsScreen()),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 16,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, Summer!",
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Ready for a quest today?",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("⭐ $points",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),

              // Section D: setState toggles the UI
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildModeTab("Solo Mode", true),
                    _buildModeTab("Friendship Mode", false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section E: ListView.builder
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: _openQuestSelection,
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image,
                                size: 40, color: Colors.grey),
                            const SizedBox(height: 10),
                            ...List.generate(3, (i) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text("Quest Level ${i + 1}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10)),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Navigation menu
              _buildMenuItem(Icons.lock, "Blocked Apps", _openBlockedApps),
              _buildMenuItem(
                  Icons.history, "Previous Quest", _openQuestSelection),
              _buildMenuItem(
                  Icons.camera_alt, "Recent Memories", _openProfile),
            ],
          ),
        ),
      ),
      // Simple bottom nav to reach screens (Section B)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1F483D),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Quests'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Apps'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Section D: if/else real decision
          if (index == 1) {
            _openQuestSelection();
          } else if (index == 2) {
            _openBlockedApps();
          } else if (index == 3) {
            _openProfile();
          }
        },
      ),
    );
  }

  Widget _buildModeTab(String title, bool isSolo) {
    final isActive = isSoloMode == isSolo;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Section D: setState
          setState(() {
            isSoloMode = isSolo;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 10),
            Text(title,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
