import 'package:flutter/material.dart';
import 'edit_dialog.dart';

/// Floating Action Button with text control menu
/// Main features: Edit text and toggle visibility
class ControlFab extends StatelessWidget {
  final String text;
  final bool isVisible;
  final Function(String) onTextChange;
  final VoidCallback onToggle;

  const ControlFab({
    super.key,
    required this.text,
    required this.isVisible,
    required this.onTextChange,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          showDialog(
            context: context,
            builder: (_) => EditDialog(currentText: text, onSave: onTextChange),
          );
        } else if (value == 'toggle') {
          onToggle();
        }
      },
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit Text')],
          ),
        ),
        PopupMenuItem(
          value: 'toggle',
          child: Row(
            children: [
              Icon(isVisible ? Icons.visibility_off : Icons.visibility),
              const SizedBox(width: 8),
              Text(isVisible ? 'Hide Text' : 'Show Text'),
            ],
          ),
        ),
      ],
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.text_format, color: Colors.white),
      ),
    );
  }
}
