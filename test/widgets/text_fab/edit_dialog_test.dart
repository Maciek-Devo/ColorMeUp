import 'package:colormeup/widgets/text_fab/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditDialog Widget Tests', () {
    // Test constant to avoid magic numbers
    const int maxTextLength = 40;

    testWidgets('displays dialog with initial content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(currentText: 'Initial', onSave: (_) => {}),
          ),
        ),
      );

      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Initial'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('calls onSave with valid input', (tester) async {
      String result = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(currentText: '', onSave: (v) => result = v),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'New');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(result, equals('New'));
    });

    testWidgets('shows error on empty text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(currentText: 'Text', onSave: (_) => {}),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      expect(find.text('Text cannot be empty'), findsOneWidget);
      expect(
        tester
            .widget<TextButton>(find.widgetWithText(TextButton, 'Save'))
            .onPressed,
        isNull,
      );
    });

    testWidgets('shows error when text too long', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(currentText: '', onSave: (_) => {}),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'a' * maxTextLength);
      await tester.pump();

      expect(find.textContaining('Text too long'), findsOneWidget);
    });

    testWidgets('cancel does not call onSave', (tester) async {
      String result = 'unchanged';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EditDialog(currentText: 'abc', onSave: (v) => result = v),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'changed');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, equals('unchanged'));
    });
  });
}
