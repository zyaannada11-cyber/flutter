import 'package:flutter/material.dart';

class BlockedAppsScreen extends StatefulWidget {
  const BlockedAppsScreen({super.key});

  @override
  State<BlockedAppsScreen> createState() => _BlockedAppsScreenState();
}

class _BlockedAppsScreenState extends State<BlockedAppsScreen> {
  // Section D: StatefulWidget
  final List<Map<String, dynamic>> apps = [
    {"name": "Instagram", "sub": "1 quest remaining", "icon": Icons.camera},
    {"name": "Netflix", "sub": "2 quests remaining", "icon": Icons.movie},
    {"name": "Snapchat", "sub": "All quests completed", "icon": Icons.snapchat},
    {"name": "TikTok", "sub": "All quests completed", "icon": Icons.music_note},
    {"name": "YouTube", "sub": "2 quests remaining", "icon": Icons.play_arrow},
  ];

  // Section C: TextEditingController for the search box
  final TextEditingController _searchController = TextEditingController();
  final Set<String> unlockedApps = {};
  String query = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleLock(String name) {
    // Section D: if/else real decision
    setState(() {
      if (unlockedApps.contains(name)) {
        unlockedApps.remove(name);
      } else {
        unlockedApps.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredApps = apps
        .where((app) =>
            (app['name'] as String).toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blocked Apps"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Section E: ListView.builder with ListTile
          Expanded(
            child: filteredApps.isEmpty
                ? const Center(child: Text("No apps found"))
                : ListView.builder(
                    itemCount: filteredApps.length,
                    itemBuilder: (context, index) {
                      final app = filteredApps[index];
                      final name = app['name'] as String;
                      final isUnlocked = unlockedApps.contains(name);
                      return ListTile(
                        leading: Icon(app['icon'] as IconData),
                        title: Text(name),
                        subtitle:
                            Text(isUnlocked ? "Unlocked!" : app['sub'] as String),
                        trailing: Icon(
                          isUnlocked ? Icons.lock_open : Icons.lock,
                          color: isUnlocked ? Colors.green : Colors.grey,
                        ),
                        onTap: () => _toggleLock(name),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
