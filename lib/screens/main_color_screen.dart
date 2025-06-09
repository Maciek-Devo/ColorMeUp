import 'dart:math';

import 'package:colormeup/widgets/text_fab/control_fab.dart';
import 'package:colormeup/widgets/text_fab/text_display.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Main app screen with color changing functionality
/// Key features: Random background colors, text display, text editing
class MainColorScreen extends StatefulWidget {
  /// Constructor for MainColorScreen widget
  const MainColorScreen({super.key});

  @override
  State<MainColorScreen> createState() => _MainColorScreenState();
}

class _MainColorScreenState extends State<MainColorScreen> {
  // Constants for color generation
  static const int _maxAlphaValue = 255;
  static const int _maxRgbValue = 256;

  final Random _random = Random();

  Color _backgroundColor = Colors.white;
  String _text = 'Hello there';
  bool _showText = true;

  /// Generates random RGB color for background
  void _changeColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        _maxAlphaValue,
        _random.nextInt(_maxRgbValue),
        _random.nextInt(_maxRgbValue),
        _random.nextInt(_maxRgbValue),
      );
    });
  }

  /// Updates displayed text
  void _updateText(String newText) {
    setState(() => _text = newText);
  }

  /// Toggles text visibility
  void _toggleText() {
    setState(() => _showText = !_showText);
  }

  /// Opens solid_lints package URL
  Future<void> _openSolidLintsUrl() async {
    final Uri url = Uri.parse('https://pub.dev/packages/solid_lints');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          GestureDetector(
            onTap: _changeColor,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: _backgroundColor,
              alignment: Alignment.center,
              child: TextDisplay(text: _text, isVisible: _showText),
            ),
          ),
          // Solid lints badge in bottom left corner
          Positioned(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Left part - "style" on grey background
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'style',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Right part - "solid" on orange background
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'solid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ControlFab(
        text: _text,
        isVisible: _showText,
        onTextChange: _updateText,
        onToggle: _toggleText,
      ),
    );
  }
}
