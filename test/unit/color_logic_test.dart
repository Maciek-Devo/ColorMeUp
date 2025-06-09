import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Generation Logic Tests', () {
    // Constants for color testing
    const int maxAlphaValue = 255;
    const int maxRgbValue = 256;
    const int testIterations = 10;
    const int colorVariations = 5;
    const int testColorAlpha = 255;
    const int testColorRed = 100;
    const int testColorGreen = 150;
    const int testColorBlue = 200;
    const int rgbMaxValue = 255;
    const int minExpectedVariations = 1;
    const int hexMask = 0xff; // Hexadecimal mask for 8-bit values

    test('Random color generation produces valid RGB values', () {
      final random = Random();

      // Generate random colors to test
      for (int i = 0; i < testIterations; i++) {
        final color = Color.fromARGB(
          maxAlphaValue,
          random.nextInt(maxRgbValue),
          random.nextInt(maxRgbValue),
          random.nextInt(maxRgbValue),
        );

        // Test that all RGB values are within valid range (0-255)
        expect(
          (color.r * rgbMaxValue).round() & hexMask,
          inInclusiveRange(0, rgbMaxValue),
        );
        expect(
          (color.g * rgbMaxValue).round() & hexMask,
          inInclusiveRange(0, rgbMaxValue),
        );
        expect(
          (color.b * rgbMaxValue).round() & hexMask,
          inInclusiveRange(0, rgbMaxValue),
        );
        expect(
          (color.a * rgbMaxValue).round() & hexMask,
          equals(rgbMaxValue),
        ); // Always fully opaque
      }
    });

    test('Generated colors are different on multiple calls', () {
      final random = Random();
      final colors = <Color>[];

      // Generate colors
      for (int i = 0; i < colorVariations; i++) {
        colors.add(
          Color.fromARGB(
            maxAlphaValue,
            random.nextInt(maxRgbValue),
            random.nextInt(maxRgbValue),
            random.nextInt(maxRgbValue),
          ),
        );
      }

      // Check that at least some colors are different
      // (statistically very unlikely to get 5 identical colors)
      final uniqueColors = colors.toSet();
      expect(uniqueColors.length, greaterThan(minExpectedVariations));
    });

    test('Color contains expected properties', () {
      const testColor = Color.fromARGB(
        testColorAlpha,
        testColorRed,
        testColorGreen,
        testColorBlue,
      );

      expect(
        (testColor.a * rgbMaxValue).round() & hexMask,
        equals(rgbMaxValue),
      );
      expect(
        (testColor.r * rgbMaxValue).round() & hexMask,
        equals(testColorRed),
      );
      expect(
        (testColor.g * rgbMaxValue).round() & hexMask,
        equals(testColorGreen),
      );
      expect(
        (testColor.b * rgbMaxValue).round() & hexMask,
        equals(testColorBlue),
      );
    });
  });
}
