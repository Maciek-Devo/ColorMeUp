import 'dart:math';

import 'package:colormeup/widgets/main_fab/main_fab.dart';
import 'package:colormeup/widgets/solid_lints_badge.dart';
import 'package:colormeup/widgets/text_fab/text_display.dart';
import 'package:flutter/material.dart';

/// Main app screen with color changing functionality
/// Key features: Random background colors, text display, text editing
class MainColorScreen extends StatefulWidget {
  /// Constructor for MainColorScreen widget
  const MainColorScreen({super.key});

  @override
  State<MainColorScreen> createState() => _MainColorScreenState();
}

class _MainColorScreenState extends State<MainColorScreen> {
  static const int _maxRgbValue = 256;
  static const int _maxHistorySize = 5;

  final Random _random = Random();

  Color _backgroundColor = Colors.white;
  String _text = 'Hello there';
  bool _showText = true;
  List<Color> _colorHistory = [];

  /// Generates random RGB color for background and adds to history
  void _changeColor() {
    final newColor = Color.fromRGBO(
      _random.nextInt(_maxRgbValue),
      _random.nextInt(_maxRgbValue),
      _random.nextInt(_maxRgbValue),
      1.0,
    );

    setState(() {
      _backgroundColor = newColor;
      _addToHistory(newColor);
    });
  }

  /// Adds color to history (max 5 items)
  void _addToHistory(Color color) {
    _colorHistory.insert(0, color);
    if (_colorHistory.length > _maxHistorySize) {
      _colorHistory = _colorHistory.take(_maxHistorySize).toList();
    }
  }

  /// Updates displayed text
  void _updateText(String newText) => setState(() => _text = newText);

  /// Toggles text visibility
  void _toggleText() => setState(() => _showText = !_showText);

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
          // Solid lints badge
          const SolidLintsBadge(),
        ],
      ),
      floatingActionButton: MainFab(
        text: _text,
        isTextVisible: _showText,
        colorHistory: _colorHistory,
        onTextChange: _updateText,
        onToggleText: _toggleText,
      ),
    );
  }
}
