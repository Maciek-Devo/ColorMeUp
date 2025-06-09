import 'package:flutter/material.dart';

/// Simple text display widget with styled background
/// Main feature: Shows/hides text with professional styling
class TextDisplay extends StatelessWidget {
  final String text;
  final bool isVisible;

  const TextDisplay({super.key, required this.text, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(179), // 70% opacity
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 2), blurRadius: 8, color: Colors.black12),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}
