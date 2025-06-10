import 'package:colormeup/screens/main_color_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainColorScreen Widget Tests', () {
    testWidgets('Initial state is correct', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      expect(find.text('Hello there'), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Main FAB expands and shows additional FABs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('Toggles text visibility using bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      // Hide text
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hide Text'));
      await tester.pumpAndSettle();
      expect(find.text('Hello there'), findsNothing);

      // Show text again
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Show Text'));
      await tester.pumpAndSettle();
      expect(find.text('Hello there'), findsOneWidget);
    });
  });
}
