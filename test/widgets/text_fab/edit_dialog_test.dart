import 'package:colormeup/widgets/text_fab/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditDialog Widget Tests', () {
    testWidgets('Dialog displays with current text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(
              currentText: 'Initial Text',
              onSave: (_) {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Verify dialog elements
      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Initial Text'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Save button calls onSave with new text', (
      WidgetTester tester,
    ) async {
      String savedText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(
              currentText: 'Initial Text',
              onSave: (text) => savedText = text,
            ),
          ),
        ),
      );

      // Enter new text
      await tester.enterText(find.byType(TextField), 'New Text');

      // Tap save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify text was saved
      expect(savedText, equals('New Text'));
    });

    testWidgets('Empty text defaults to "Hello there"', (
      WidgetTester tester,
    ) async {
      String savedText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(
              currentText: 'Initial Text',
              onSave: (text) => savedText = text,
            ),
          ),
        ),
      );

      // Clear text field
      await tester.enterText(find.byType(TextField), '');

      // Tap save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify default text is used
      expect(savedText, equals('Hello there'));
    });

    testWidgets('TextField has correct properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(
              currentText: 'Test Text',
              onSave: (_) {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Verify TextField properties
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, isTrue);
      expect(textField.decoration?.hintText, equals('Enter new text...'));
    });

    testWidgets('Cancel button closes dialog without saving', (
      WidgetTester tester,
    ) async {
      String savedText = 'unchanged';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(
              currentText: 'Initial Text',
              onSave: (text) => savedText = text,
            ),
          ),
        ),
      );

      // Enter text but cancel
      await tester.enterText(find.byType(TextField), 'Changed Text');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify text was not saved
      expect(savedText, equals('unchanged'));
    });
  });
}
