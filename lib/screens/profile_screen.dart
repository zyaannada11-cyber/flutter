import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Section B: Navigator.pop
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 35, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text("Summer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Exploring the world, one quest at a time ✨",
                style: TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lvl 12",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text("XP Earned 2,450 / 5,000",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.49,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Section E: ListView.builder for gallery
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Your Picture Gallery",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
