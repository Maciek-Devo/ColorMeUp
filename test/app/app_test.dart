import 'package:colormeup/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Tests', () {
    testWidgets('App initializes with correct setup', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());

      // Verify MaterialApp is created
      expect(find.byType(MaterialApp), findsOneWidget);

      // Verify debug banner is disabled
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);

      // Verify initial content loads
      expect(find.text('Hello there'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('App has proper theme setup', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Verify app structure
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
