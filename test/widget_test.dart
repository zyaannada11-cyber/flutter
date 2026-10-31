import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:summer_quest_app/main.dart';

void main() {
  testWidgets('Home screen shows greeting and menu', (tester) async {
    await tester.pumpWidget(const SummerQuestApp());

    expect(find.text('Hi, Summer!'), findsOneWidget);
    expect(find.text('Blocked Apps'), findsOneWidget);
    expect(find.text('Previous Quest'), findsOneWidget);
    expect(find.text('Recent Memories'), findsOneWidget);
  });

  testWidgets('Empty name shows SnackBar, filled name opens quest',
      (tester) async {
    await tester.pumpWidget(const SummerQuestApp());

    // Switch to Friendship Mode on Home, then open Quest Selection
    await tester.tap(find.text('Friendship Mode'));
    await tester.pump();
    await tester.tap(find.text('Previous Quest'));
    await tester.pumpAndSettle();
    expect(find.text('Choose Your Path'), findsOneWidget);

    // Empty input -> SnackBar
    await tester.tap(find.text('Start Quest'));
    await tester.pump();
    expect(find.text('Please enter your name to start!'), findsOneWidget);

    // Filled input -> Quest In Progress with data from constructor
    await tester.enterText(find.byType(TextField), 'Zya');
    await tester.tap(find.text('2. Quest Level 2'));
    await tester.pumpAndSettle();
    expect(find.text('Good luck, Zya!'), findsOneWidget);
    expect(find.text('Mode: Friendship Mode'), findsOneWidget);
    expect(find.text('Quest Level 2 in Progress :'), findsOneWidget);

    // Navigator.pop back to Quest Selection
    await tester.tap(find.text('done and dusted'));
    await tester.pumpAndSettle();
    expect(find.text('Choose Your Path'), findsOneWidget);
  });

  testWidgets('Blocked apps can be searched and unlocked', (tester) async {
    await tester.pumpWidget(const SummerQuestApp());

    await tester.tap(find.text('Blocked Apps'));
    await tester.pumpAndSettle();
    expect(find.text('Instagram'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'net');
    await tester.pump();
    expect(find.text('Netflix'), findsOneWidget);
    expect(find.text('Instagram'), findsNothing);

    await tester.tap(find.text('Netflix'));
    await tester.pump();
    expect(find.text('Unlocked!'), findsOneWidget);
  });

  testWidgets('Every screen fits on a small phone', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SummerQuestApp());

    for (final label in ['Quests', 'Apps', 'Profile']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Quests'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Zya');
    await tester.tap(find.text('Start Quest'));
    await tester.pumpAndSettle();
    expect(find.text('Good luck, Zya!'), findsOneWidget);
  });

  testWidgets('Bottom nav opens Profile', (tester) async {
    await tester.pumpWidget(const SummerQuestApp());

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Your Picture Gallery'), findsOneWidget);
  });
}
