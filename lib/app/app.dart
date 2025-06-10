import 'package:colormeup/screens/main_color_screen.dart';
import 'package:flutter/material.dart';

/// Main application class – entry point for the ColorMeUp app.
/// Sets up the basic MaterialApp configuration.
class App extends StatelessWidget {
  /// Constructor for the main application widget.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainColorScreen(),
    );
  }
}
