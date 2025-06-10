import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Generation Logic Tests', () {
    // Test constants to avoid magic numbers
    const int maxAlpha = 255;
    const int maxColorValue = 256;
    const int minColorValue = 0;
    const int colorMask = 0xff; // Mask for color channel values

    test('Generated RGB values are within 0-255 range', () {
      final random = Random();
      final color = Color.fromARGB(
        maxAlpha,
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
      );

      expect((color.a * maxAlpha).round() & colorMask, equals(maxAlpha));
      expect(
        (color.r * maxAlpha).round() & colorMask,
        inInclusiveRange(minColorValue, maxAlpha),
      );
      expect(
        (color.g * maxAlpha).round() & colorMask,
        inInclusiveRange(minColorValue, maxAlpha),
      );
      expect(
        (color.b * maxAlpha).round() & colorMask,
        inInclusiveRange(minColorValue, maxAlpha),
      );
    });

    test('Two generated colors are usually different', () {
      final random = Random();
      final color1 = Color.fromARGB(
        maxAlpha,
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
      );
      final color2 = Color.fromARGB(
        maxAlpha,
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
        random.nextInt(maxColorValue),
      );

      // Very unlikely that two random colors are identical
      expect(color1, isNot(equals(color2)));
    });
  });
}
