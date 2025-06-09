import 'package:colormeup/screens/main_color_screen.dart';
import 'package:flutter/material.dart';

/// Główna klasa aplikacji - punkt wejścia dla aplikacji ColorMeUp
/// Konfiguruje podstawowe ustawienia MaterialApp
class App extends StatelessWidget {
  /// Konstruktor dla głównej aplikacji
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainColorScreen(),
    );
  }
}
