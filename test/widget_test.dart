// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:colormeup/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Color app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ColorMeUpApp());

    // Verify that our app displays the initial text.
    expect(find.text('Hello there'), findsOneWidget);

    // Tap the screen to change color and trigger a frame.
    await tester.tap(find.text('Hello there'));
    await tester.pump();

    // Verify that the text is still there after tap.
    expect(find.text('Hello there'), findsOneWidget);
  });
}
