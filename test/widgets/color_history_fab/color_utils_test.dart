import 'package:colormeup/widgets/color_history_fab/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorUtils Tests', () {
    test('toRgbString converts color to correct RGB format', () {
      const color = Color(0xFF123456);
      final result = ColorUtils.toRgbString(color);
      expect(result, equals('RGB(18, 52, 86)'));
    });

    test('toHexString converts color to correct HEX format', () {
      const color = Color(0xFF123456);
      final result = ColorUtils.toHexString(color);
      expect(result, equals('#123456'));
    });

    test('Formats are valid and consistent', () {
      const color = Color(0xFFABCDEF);
      final rgb = ColorUtils.toRgbString(color);
      final hex = ColorUtils.toHexString(color);

      expect(rgb, matches(r'RGB\(\d{1,3}, \d{1,3}, \d{1,3}\)'));
      expect(hex, matches('#[0-9A-F]{6}'));
    });
  });
}
