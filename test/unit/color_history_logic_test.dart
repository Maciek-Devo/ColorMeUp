import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color History Logic Tests', () {
    const int maxHistorySize = 5;
    const int testColorCount = 7;
    const int expectedDuplicates = 2;
    const Color baseTestColor = Color(0xFF000000);
    const int colorIncrement = 0x111111;

    List<Color> colorHistory = [];

    setUp(() {
      colorHistory = [];
    });

    void addToHistory(Color color) {
      colorHistory.insert(0, color);
      if (colorHistory.length > maxHistorySize) {
        colorHistory = colorHistory.take(maxHistorySize).toList();
      }
    }

    test('First color is added correctly', () {
      const red = Color(0xFFFF0000);
      addToHistory(red);
      expect(colorHistory.length, equals(1));
      expect(colorHistory.first, equals(red));
    });

    test('New colors are added to the top, oldest are removed after 5', () {
      for (int i = 0; i < testColorCount; i++) {
        addToHistory(Color(baseTestColor.toARGB32() + i * colorIncrement));
      }
      expect(colorHistory.length, equals(maxHistorySize));
      expect(colorHistory.first, equals(const Color(0xFF666666)));
      expect(colorHistory.contains(baseTestColor), isFalse);
    });

    test('Duplicate colors are preserved', () {
      const color = Color(0xFFFF0000);
      addToHistory(color);
      addToHistory(color);
      expect(colorHistory.length, equals(expectedDuplicates));
      expect(colorHistory.first, equals(color));
      expect(colorHistory[1], equals(color));
    });
  });
}
