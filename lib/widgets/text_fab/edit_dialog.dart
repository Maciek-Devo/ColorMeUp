import 'package:flutter/material.dart';

/// Simple text edit dialog.
/// Allows users to edit a text value with basic validation (1–30 characters).
class EditDialog extends StatefulWidget {
  /// Constructor for the EditDialog widget.
  const EditDialog({
    required this.currentText,
    required this.onSave,
    super.key,
  });

  /// The current text to be edited.
  final String currentText;

  /// Callback triggered when the new text is saved.
  final Function(String) onSave;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  static const int _maxLength = 30;

  TextEditingController? _controller;
  String _currentText = '';
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentText);
    _currentText = widget.currentText;
    _controller?.addListener(_onTextChanged);
  }

  /// Called whenever the text field changes.
  /// Updates the local state and performs validation.
  void _onTextChanged() {
    final controller = _controller;
    if (controller != null) {
      setState(() {
        _currentText = controller.text;
        _errorText = _validateText(_currentText);
      });
    }
  }

  /// Validates the input text and returns an error message if invalid.
  String? _validateText(String text) {
    if (text.isEmpty) {
      return 'Text cannot be empty';
    }
    if (text.length > _maxLength) {
      return 'Text too long (max $_maxLength characters)';
    }

    return null;
  }

  /// Returns whether the input is valid.
  bool get _isValid => _errorText == null && _currentText.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Text'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter new text...',
              border: const OutlineInputBorder(),
              errorText: _errorText,
            ),
            autofocus: true,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Character count
              Text(
                'Characters: ${_currentText.length}/$_maxLength',
                style: TextStyle(
                  fontSize: 12,
                  color: _currentText.length > _maxLength
                      ? Colors.red
                      : Colors.grey[600],
                ),
              ),
              // Validity indicator icon
              if (_currentText.isNotEmpty)
                Icon(
                  _isValid ? Icons.check_circle : Icons.error,
                  size: 16,
                  color: _isValid ? Colors.green : Colors.red,
                ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isValid
              ? () {
                  widget.onSave(_currentText.trim());
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTextChanged);
    _controller?.dispose();
    super.dispose();
  }
}
