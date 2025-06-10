import 'package:colormeup/widgets/text_fab/text_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextDisplay Widget', () {
    // Test constant to avoid magic numbers
    const double expectedFontSize = 28;

    testWidgets('shows text when visible', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TextDisplay(text: 'Visible', isVisible: true)),
        ),
      );

      expect(find.text('Visible'), findsOneWidget);
    });

    testWidgets('hides text when not visible', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TextDisplay(text: 'Hidden', isVisible: false)),
        ),
      );

      expect(find.text('Hidden'), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('applies styling and layout', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TextDisplay(text: 'Styled', isVisible: true)),
        ),
      );

      final text = tester.widget<Text>(find.text('Styled'));
      expect(text.style?.fontSize, expectedFontSize);
      expect(text.style?.fontWeight, FontWeight.bold);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, const EdgeInsets.all(16));
      expect(container.decoration, isNotNull);
    });
  });
}
