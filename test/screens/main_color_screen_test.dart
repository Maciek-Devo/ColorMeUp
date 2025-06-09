import 'package:colormeup/screens/main_color_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainColorScreen Tests', () {
    testWidgets('Screen loads with initial state', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      // Verify initial text is displayed
      expect(find.text('Hello there'), findsOneWidget);

      // Verify FAB is present
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);

      // Verify GestureDetector for screen taps
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('FAB opens bottom sheet menu', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      // Tap FAB to open menu
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify bottom sheet options appear
      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Hide Text'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('Hide/Show text toggle works', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      // Initially text should be visible
      expect(find.text('Hello there'), findsOneWidget);

      // Hide text
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hide Text'));
      await tester.pumpAndSettle();

      // Text should be hidden
      expect(find.text('Hello there'), findsNothing);

      // Show text again
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Show Text'));
      await tester.pumpAndSettle();

      // Text should be visible again
      expect(find.text('Hello there'), findsOneWidget);
    });

    testWidgets('Edit dialog opens correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainColorScreen()));

      // Open edit dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit Text'));
      await tester.pumpAndSettle();

      // Verify edit dialog components
      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
