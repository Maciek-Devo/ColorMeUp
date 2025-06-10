import 'package:colormeup/widgets/color_history_fab/color_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorTile Widget Tests', () {
    testWidgets('Displays RGB and HEX values', (WidgetTester tester) async {
      const testColor = Color(0xFFFF0000); // Red

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorTile(color: testColor)),
        ),
      );

      expect(find.text('RGB(255, 0, 0)'), findsOneWidget);
      expect(find.text('#FF0000'), findsOneWidget);
    });

    testWidgets('Tapping RGB copy button shows SnackBar', (
      WidgetTester tester,
    ) async {
      const testColor = Color(0xFF00FF00); // Green

      // Mock clipboard
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
            if (call.method == 'Clipboard.setData') return;

            return null;
          });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorTile(color: testColor)),
        ),
      );

      await tester.tap(find.byIcon(Icons.copy).first);
      await tester.pumpAndSettle();

      expect(find.text('RGB copied!'), findsOneWidget);
    });

    testWidgets('Tapping HEX copy button shows SnackBar', (
      WidgetTester tester,
    ) async {
      const testColor = Color(0xFF0000FF); // Blue

      // Mock clipboard
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
            if (call.method == 'Clipboard.setData') return;

            return null;
          });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ColorTile(color: testColor)),
        ),
      );

      await tester.tap(find.byIcon(Icons.copy).last);
      await tester.pumpAndSettle();

      expect(find.text('HEX copied!'), findsOneWidget);
    });
  });
}
