import 'package:flutter/material.dart';

/// Utilities for working with colors
/// Converts colors to RGB and HEX string formats
class ColorUtils {
  /// Converts a color to the RGB(r, g, b) format
  static String toRgbString(Color color) {
    final r = (color.r * 255.0).round() & 0xff;
    final g = (color.g * 255.0).round() & 0xff;
    final b = (color.b * 255.0).round() & 0xff;

    return 'RGB($r, $g, $b)';
  }

  /// Converts a color to the HEX #RRGGBB format
  static String toHexString(Color color) {
    final r = ((color.r * 255.0).round() & 0xff)
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();
    final g = ((color.g * 255.0).round() & 0xff)
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();
    final b = ((color.b * 255.0).round() & 0xff)
        .toRadixString(16)
        .padLeft(2, '0')
        .toUpperCase();

    return '#$r$g$b';
  }
}
