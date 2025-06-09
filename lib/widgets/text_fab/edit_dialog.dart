import 'package:flutter/material.dart';

/// Simple text edit dialog
/// Main feature: Edit text with input validation
class EditDialog extends StatelessWidget {
  final String currentText;
  final Function(String) onSave;

  const EditDialog({
    super.key,
    required this.currentText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: currentText);

    return AlertDialog(
      title: const Text('Edit Text'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter new text...',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newText = controller.text.trim();
            onSave(newText.isEmpty ? 'Hello there' : newText);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
