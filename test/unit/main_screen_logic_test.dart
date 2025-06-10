import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Main Screen Logic Tests', () {
    // Constants
    const int maxHistorySize = 5;
    const Color defaultBackgroundColor = Colors.white;
    const String defaultText = 'Hello there';
    const int randomSeed = 42;
    const int maxColorValue = 256;
    const int testIterationCount = 10;

    // Simulated state
    Color backgroundColor = defaultBackgroundColor;
    String text = defaultText;
    bool showText = true;
    List<Color> colorHistory = [];
    Random random = Random(randomSeed);

    setUp(() {
      backgroundColor = defaultBackgroundColor;
      text = defaultText;
      showText = true;
      colorHistory = [];
      random = Random(randomSeed); // Predictable results
    });

    // Simulate logic methods
    Color changeColor() {
      final newColor = Color.fromRGBO(
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        1.0,
      );
      backgroundColor = newColor;
      colorHistory.insert(0, newColor);
      if (colorHistory.length > maxHistorySize) {
        colorHistory = colorHistory.take(maxHistorySize).toList();
      }

      return newColor;
    }

    void updateText(String newText) {
      text = newText;
    }

    void toggleText() {
      showText = !showText;
    }

    // Key tests
    test('Initial state is correct', () {
      expect(backgroundColor, equals(defaultBackgroundColor));
      expect(text, equals(defaultText));
      expect(showText, isTrue);
      expect(colorHistory, isEmpty);
    });

    test('Color changes and adds to history', () {
      final newColor = changeColor();
      expect(backgroundColor, equals(newColor));
      expect(colorHistory.first, equals(newColor));
      expect(colorHistory.length, equals(1));
    });

    test('Color history is capped at 5 items', () {
      for (int i = 0; i < testIterationCount; i++) {
        changeColor();
      }
      expect(colorHistory.length, equals(maxHistorySize));
    });

    test('Text can be updated', () {
      updateText('New Text');
      expect(text, equals('New Text'));
    });

    test('Text visibility toggles correctly', () {
      expect(showText, isTrue);
      toggleText();
      expect(showText, isFalse);
      toggleText();
      expect(showText, isTrue);
    });

    test('Changing color does not affect text', () {
      updateText('My Text');
      toggleText();
      final prevText = text;
      final prevVisible = showText;

      changeColor();

      expect(text, equals(prevText));
      expect(showText, equals(prevVisible));
    });
  });
}
