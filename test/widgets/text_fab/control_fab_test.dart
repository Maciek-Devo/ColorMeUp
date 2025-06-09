import 'package:colormeup/widgets/text_fab/control_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ControlFab Widget Tests', () {
    testWidgets('FAB displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: true,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Verify FAB is displayed
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('FAB opens bottom sheet on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: true,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Tap FAB to open bottom sheet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify bottom sheet options
      expect(find.text('Edit Text'), findsOneWidget);
      expect(find.text('Hide Text'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('Shows correct visibility option when text is visible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: true,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Open bottom sheet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Should show "Hide Text" when text is visible
      expect(find.text('Hide Text'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('Shows correct visibility option when text is hidden', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: false,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Open bottom sheet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Should show "Show Text" when text is hidden
      expect(find.text('Show Text'), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('Toggle callback is called when visibility option is tapped', (
      WidgetTester tester,
    ) async {
      bool toggleCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: true,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () => toggleCalled = true,
            ),
          ),
        ),
      );

      // Open bottom sheet and tap toggle option
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hide Text'));
      await tester.pumpAndSettle();

      // Verify toggle was called
      expect(toggleCalled, isTrue);
    });

    testWidgets('Edit dialog opens when Edit Text is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlFab(
              text: 'Test Text',
              isVisible: true,
              onTextChange: (_) {
                // Test callback - no action needed for this test
                return;
              },
              onToggle: () {
                // Test callback - no action needed for this test
                return;
              },
            ),
          ),
        ),
      );

      // Open bottom sheet and tap edit option
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit Text'));
      await tester.pumpAndSettle();

      // Verify edit dialog appears
      expect(find.text('Edit Text'), findsWidgets);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
