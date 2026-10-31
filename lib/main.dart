import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SummerQuestApp());
}

class SummerQuestApp extends StatelessWidget {
  const SummerQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Summer Quest',
      debugShowCheckedModeBanner: false,
      // Consistent theme (Section B)
      theme: ThemeData(
        primaryColor: const Color(0xFF1F483D),
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F483D),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
