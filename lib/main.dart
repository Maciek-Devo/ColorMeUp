import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const ColorMeUpApp());
}

/// The root widget of the application.
class ColorMeUpApp extends StatelessWidget {
  const ColorMeUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorScreen(),
    );
  }
}

/// A screen that changes its background color on tap.
class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final Random _random = Random();

  /// Holds the current background color of the screen.
  Color _backgroundColor = Colors.white;

  /// Generates a new random RGB color and updates the UI.
  void _generateRandomBackgroundColor() {
    final int red = _random.nextInt(256);
    final int green = _random.nextInt(256);
    final int blue = _random.nextInt(256);

    setState(() {
      _backgroundColor = Color.fromARGB(255, red, green, blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _generateRandomBackgroundColor, // Change color on screen tap
      child: Container(
        color: _backgroundColor,
        alignment: Alignment.center,
        child: const Text(
          'Hello there',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
