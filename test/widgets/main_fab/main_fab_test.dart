import 'package:colormeup/widgets/main_fab/main_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainFab Widget Tests', () {
    Widget buildTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: MainFab(
            text: 'Test Text',
            isTextVisible: true,
            colorHistory: const [Colors.red, Colors.blue],
            onTextChange: (_) => {},
            onToggleText: () => {},
          ),
        ),
      );
    }

    testWidgets('Main FAB shows and expands', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byIcon(Icons.more_vert), findsOneWidget);

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('Close icon collapses FABs', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Tapping history FAB opens modal', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();

      expect(find.text('Color History'), findsOneWidget);
    });
  });
}
