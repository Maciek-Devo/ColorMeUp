import 'package:colormeup/widgets/color_history_fab/color_history_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorHistoryFab Widget Tests', () {
    testWidgets('FAB shows and opens modal', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryFab(colorHistory: [Colors.red])),
        ),
      );

      // Verify FAB and icon
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);

      // Tap FAB to open modal
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Modal should appear
      expect(find.text('Color History'), findsOneWidget);
    });

    testWidgets('Empty history shows empty message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorHistoryFab(colorHistory: [])),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'No colors in history yet.\nTap the screen to generate colors!',
        ),
        findsOneWidget,
      );
    });
  });
}
