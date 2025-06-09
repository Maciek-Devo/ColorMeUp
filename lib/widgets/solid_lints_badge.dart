import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Badge widget for solid_lints package promotion
/// Displays a clickable badge that opens the package URL
class SolidLintsBadge extends StatelessWidget {
  /// Constructor for SolidLintsBadge widget
  const SolidLintsBadge({super.key});

  /// Opens solid_lints package URL
  Future<void> _openSolidLintsUrl() async {
    final Uri url = Uri.parse('https://pub.dev/packages/solid_lints');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      child: GestureDetector(
        onTap: _openSolidLintsUrl,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(51), // ~20% opacity
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BadgeSegment(
                text: 'style',
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                fontWeight: FontWeight.w500,
              ),
              _BadgeSegment(
                text: 'solid',
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Private widget for badge segments to reduce code duplication
class _BadgeSegment extends StatelessWidget {
  /// Text to display
  final String text;

  /// Background color
  final Color color;

  /// Border radius for segment
  final BorderRadius borderRadius;

  /// Font weight for text
  final FontWeight fontWeight;

  /// Constructor for _BadgeSegment
  const _BadgeSegment({
    required this.text,
    required this.color,
    required this.borderRadius,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
