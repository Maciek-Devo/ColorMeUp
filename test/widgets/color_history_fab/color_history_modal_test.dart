import 'package:colormeup/widgets/color_history_fab/color_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorHistoryModal Widget Tests', () {
    testWidgets('Header and close button are shown', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryModal(colorHistory: [Colors.red])),
        ),
      );

      expect(find.text('Color History'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('Shows empty message when history is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryModal(colorHistory: [])),
        ),
      );

      expect(
        find.text(
          'No colors in history yet.\n'
          'Tap the screen to generate colors!',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Displays RGB and HEX values for given colors', (
      WidgetTester tester,
    ) async {
      const colors = [Color(0xFFFF0000), Color(0xFF00FF00)];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryModal(colorHistory: colors)),
        ),
      );

      expect(find.text('RGB(255, 0, 0)'), findsOneWidget);
      expect(find.text('#FF0000'), findsOneWidget);
      expect(find.text('RGB(0, 255, 0)'), findsOneWidget);
      expect(find.text('#00FF00'), findsOneWidget);
    });

    testWidgets('Close button is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryModal(colorHistory: [Colors.red])),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump(); // No error should occur
    });
  });
}
