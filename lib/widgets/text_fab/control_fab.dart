import 'package:colormeup/widgets/text_fab/edit_dialog.dart';
import 'package:flutter/material.dart';

/// Floating Action Button (FAB) for text control options.
/// Main functionalities: edit the displayed text and toggle its visibility.
class ControlFab extends StatelessWidget {
  /// Constructor for the ControlFab widget.
  const ControlFab({
    required this.text,
    required this.isVisible,
    required this.onTextChange,
    required this.onToggle,
    super.key,
  });

  /// The current text to display.
  final String text;

  /// Whether the text is currently visible.
  final bool isVisible;

  /// Callback triggered when the text is changed.
  final Function(String) onTextChange;

  /// Callback triggered when toggling text visibility.
  final VoidCallback onToggle;

  /// Shows a bottom sheet with edit and toggle options.
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
