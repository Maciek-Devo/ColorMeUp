import 'package:colormeup/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads with expected initial UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Hello there'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
