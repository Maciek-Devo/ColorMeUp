import 'package:colormeup/widgets/color_history_fab/color_history_fab.dart';
import 'package:colormeup/widgets/text_fab/control_fab.dart';
import 'package:flutter/material.dart';

/// Main floating action button (FAB) with expandable options.
/// When tapped, it reveals the ControlFab and ColorHistoryFab.
class MainFab extends StatefulWidget {
  /// Constructor for the MainFab widget.
  const MainFab({
    required this.text,
    required this.isTextVisible,
    required this.colorHistory,
    required this.onTextChange,
    required this.onToggleText,
    super.key,
  });

  /// The current text displayed on screen.
  final String text;

  /// Whether the text overlay is currently visible.
  final bool isTextVisible;

  /// The list of recently generated colors.
  final List<Color> colorHistory;

  /// Callback triggered when the text is changed.
  final Function(String) onTextChange;

  /// Callback triggered when toggling text visibility.
  final VoidCallback onToggleText;

  @override
  State<MainFab> createState() => _MainFabState();
}

class _MainFabState extends State<MainFab> {
  bool _isExpanded = false;

  /// Toggles the expansion state of the FAB options.
  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main FAB – always visible
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _toggleExpansion,
            heroTag: 'main_fab',
            child: Icon(_isExpanded ? Icons.close : Icons.more_vert),
          ),
        ),
        // Expanded FABs – shown when main FAB is expanded
        if (_isExpanded) ...[
          // ControlFab – used to edit or toggle the overlay text
          Positioned(
            bottom: 88,
            right: 16,
            child: ControlFab(
              text: widget.text,
              isVisible: widget.isTextVisible,
              onTextChange: widget.onTextChange,
              onToggle: widget.onToggleText,
            ),
          ),
          // ColorHistoryFab – opens color history modal
          Positioned(
            bottom: 160,
            right: 16,
            child: ColorHistoryFab(colorHistory: widget.colorHistory),
          ),
        ],
      ],
    );
  }
}
