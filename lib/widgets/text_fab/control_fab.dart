import 'package:colormeup/widgets/text_fab/edit_dialog.dart';
import 'package:flutter/material.dart';

/// Floating Action Button with text control menu
/// Main features: Edit text and toggle visibility
class ControlFab extends StatelessWidget {
  /// Konstruktor dla ControlFab widget
  const ControlFab({
    required this.text,
    required this.isVisible,
    required this.onTextChange,
    required this.onToggle,
    super.key,
  });

  /// Tekst do wyświetlenia
  final String text;

  /// Czy tekst jest widoczny
  final bool isVisible;

  /// Callback do zmiany tekstu
  final Function(String) onTextChange;

  /// Callback do przełączania widoczności
  final VoidCallback onToggle;

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Text'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) =>
                      EditDialog(currentText: text, onSave: onTextChange),
                );
              },
            ),
            ListTile(
              leading: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
              ),
              title: Text(isVisible ? 'Hide Text' : 'Show Text'),
              onTap: () {
                Navigator.pop(context);
                onToggle();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showOptions(context),
      child: const Icon(Icons.edit),
    );
  }
}
