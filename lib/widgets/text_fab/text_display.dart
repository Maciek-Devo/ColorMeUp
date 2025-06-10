import 'package:flutter/material.dart';

/// Simple text display widget with a styled background.
/// Main functionality: shows or hides the text based on a visibility flag.
class TextDisplay extends StatelessWidget {
  /// Constructor for the TextDisplay widget.
  const TextDisplay({required this.text, required this.isVisible, super.key});

  /// The text content to be displayed.
  final String text;

  /// Whether the text should be visible.
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(179), // ~70% opacity
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 2), blurRadius: 8, color: Colors.black12),
        ],
      ),
      child: Builder(
        builder: (context) {
          // Adaptive font size – 8% of screen width, clamped between 16 and 26
          final double adaptiveFontSize =
              (MediaQuery.sizeOf(context).width * 0.08).clamp(16.0, 26.0);

          return Text(
            text,
            style: TextStyle(
              fontSize: adaptiveFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              shadows: const [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
