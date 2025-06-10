import 'package:colormeup/widgets/text_fab/control_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ControlFab Widget Tests', () {
    Widget buildTestWidget({required bool isVisible, Function()? onToggle}) {
      return MaterialApp(
        home: Scaffold(
          body: ControlFab(
            text: 'Test Text',
            isVisible: isVisible,
            onTextChange: (_) => {},
            onToggle: onToggle ?? () => {},
          ),
        ),
      );
    }

    testWidgets('FAB opens bottom sheet with options', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(isVisible: true));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Hide Text'), findsOneWidget);
    });

    testWidgets('Tapping toggle option calls callback', (
      WidgetTester tester,
    ) async {
      bool toggleCalled = false;

      await tester.pumpWidget(
        buildTestWidget(isVisible: true, onToggle: () => toggleCalled = true),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hide Text'));
      await tester.pumpAndSettle();

      expect(toggleCalled, isTrue);
    });

    testWidgets('Tapping Edit Text opens dialog', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(isVisible: true));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit Text'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Text'), findsWidgets);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
