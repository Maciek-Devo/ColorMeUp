import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/text_fab/text_display.dart';
import '../widgets/text_fab/control_fab.dart';

/// Main app screen with color changing functionality
/// Key features: Random background colors, text display, text editing
class MainColorScreen extends StatefulWidget {
  const MainColorScreen({super.key});

  @override
  State<MainColorScreen> createState() => _MainColorScreenState();
}

class _MainColorScreenState extends State<MainColorScreen> {
  final Random _random = Random();

  Color _backgroundColor = Colors.white;
  String _text = 'Hello there';
  bool _showText = true;

  /// Generates random RGB color for background
  void _changeColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _changeColor,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: _backgroundColor,
          alignment: Alignment.center,
          child: TextDisplay(text: _text, isVisible: _showText),
        ),
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
