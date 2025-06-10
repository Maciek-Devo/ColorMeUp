import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Main Screen Logic Tests (Simplified)', () {
    // Constants
    const int randomSeed = 42;
    const int maxColorValue = 256;
    const int maxHistorySize = 5;
    const int testIterationCount = 10;

    // Simulated screen state
    Color backgroundColor = Colors.white;
    bool showText = true;
    List<Color> colorHistory = [];
    Random random = Random(randomSeed);

    setUp(() {
      backgroundColor = Colors.white;
      showText = true;
      colorHistory = [];
      random = Random(randomSeed); // Fixed seed for predictable results
    });

    // Simulates color change logic from the main screen
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

    // Simulates toggling the visibility of the text
    void toggleText() {
      showText = !showText;
    }

    test('Changing color updates background and adds to history', () {
      final newColor = changeColor();
      expect(backgroundColor, equals(newColor));
      expect(colorHistory.first, equals(newColor));
      expect(colorHistory.length, equals(1));
    });

    test('Text visibility toggles correctly', () {
      expect(showText, isTrue);
      toggleText();
      expect(showText, isFalse);
      toggleText();
      expect(showText, isTrue);
    });

    test('Color history is capped at 5 items', () {
      for (int i = 0; i < testIterationCount; i++) {
        changeColor();
      }
      expect(colorHistory.length, equals(maxHistorySize));
    });
  });
}
