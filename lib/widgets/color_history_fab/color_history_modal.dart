import 'package:colormeup/widgets/color_history_fab/color_tile.dart';
import 'package:flutter/material.dart';

/// Modal for displaying color history.
/// Shows the last 5 generated colors in a bottom sheet.
class ColorHistoryModal extends StatelessWidget {
  /// Constructor for the ColorHistoryModal widget.
  const ColorHistoryModal({required this.colorHistory, super.key});

  /// List of recently generated colors to display.
  final List<Color> colorHistory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Enforce minimum padding from all edges to avoid system UI overlap
      minimum: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Color History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // List of colors or empty state message
            Flexible(
              child: Scrollbar(
                thumbVisibility: true, // Always show the scrollbar
                thickness: 6.0, // Make it visible but not too thick
                radius: const Radius.circular(3.0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ), // Space for scrollbar
                  child: Column(
                    children: [
                      if (colorHistory.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: Text(
                              'No colors in history yet.\n'
                              'Tap the screen to generate colors!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      else
                        // Display list of color tiles
                        ...colorHistory.map((color) => ColorTile(color: color)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
