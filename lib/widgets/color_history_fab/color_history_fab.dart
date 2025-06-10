import 'package:colormeup/widgets/color_history_fab/color_history_modal.dart';
import 'package:flutter/material.dart';

/// FAB do otwierania historii kolorów
/// Po kliknięciu pokazuje modal z ostatnimi kolorami
class ColorHistoryFab extends StatelessWidget {
  /// Konstruktor dla ColorHistoryFab widget
  const ColorHistoryFab({required this.colorHistory, super.key});

  /// Historia kolorów do wyświetlenia
  final List<Color> colorHistory;

  /// Otwiera modal z historią kolorów
  void _showColorHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ColorHistoryModal(colorHistory: colorHistory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showColorHistory(context),
      heroTag: 'color_history_fab',
      child: const Icon(Icons.history),
    );
  }
}
