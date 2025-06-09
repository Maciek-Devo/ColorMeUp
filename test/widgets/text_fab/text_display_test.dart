import 'package:colormeup/widgets/text_fab/text_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextDisplay Widget Tests', () {
    // Constants for testing
    const double expectedFontSize = 28;

    testWidgets('Shows text when isVisible is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TextDisplay(text: 'Test Text', isVisible: true)),
        ),
      );

      // Verify text is displayed
      expect(find.text('Test Text'), findsOneWidget);

      // Verify container styling is applied
      expect(find.byType(Container), findsOneWidget);

      // Verify Text widget exists
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Hides text when isVisible is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TextDisplay(text: 'Hidden Text', isVisible: false),
          ),
        ),
      );

      // Verify text is not displayed
      expect(find.text('Hidden Text'), findsNothing);

      // Verify SizedBox.shrink is used
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('Displays custom text correctly', (WidgetTester tester) async {
      const customText = 'Custom Test Message';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TextDisplay(text: customText, isVisible: true)),
        ),
      );

      // Verify custom text appears
      expect(find.text(customText), findsOneWidget);

      // Verify text style properties
      final textWidget = tester.widget<Text>(find.text(customText));
      expect(textWidget.style?.fontSize, equals(expectedFontSize));
      expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('Container has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TextDisplay(text: 'Styled Text', isVisible: true),
          ),
        ),
      );

      // Find container and verify properties
      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(const EdgeInsets.all(16)));

      // Verify decoration exists
      expect(container.decoration, isA<BoxDecoration>());
    });
  });
}
