import 'package:flutter/material.dart';
import '../screens/main_color_screen.dart';

/// Główna klasa aplikacji (ColorMeUpApp)
class ColorMeUpApp extends StatelessWidget {
  const ColorMeUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainColorScreen(),
    );
  }
}
