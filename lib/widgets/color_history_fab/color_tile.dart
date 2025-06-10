import 'dart:async';

import 'package:colormeup/utils/copy_lock.dart';
import 'package:colormeup/widgets/color_history_fab/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget representing a single color entry in the history.
/// Displays the color preview, RGB and HEX values, and copy buttons.
class ColorTile extends StatefulWidget {
  /// Constructor for the ColorTile widget.
  const ColorTile({required this.color, super.key});

  /// The color to be displayed.
  final Color color;

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  Timer? _rgbDebounceTimer;
  Timer? _hexDebounceTimer;
  bool _isRgbCopying = false;
  bool _isHexCopying = false;

  /// Copies the RGB value to clipboard with debouncing and feedback.
  Future<void> _copyRgb() async {
    if (CopyLock.isLocked || _isRgbCopying) return;

    // Immediately activate the global lock so any subsequent taps in the next
    // few hundred milliseconds will be ignored. This eliminates the window in
    // which multiple clipboard operations could overlap and freeze the UI.
    CopyLock.lock(const Duration(milliseconds: 500));

    _rgbDebounceTimer?.cancel();
    _rgbDebounceTimer = Timer(const Duration(milliseconds: 200), () async {
      if (!mounted) return;

      setState(() => _isRgbCopying = true);

      try {
        // Instant haptic feedback
        unawaited(HapticFeedback.lightImpact());

        // Compute RGB string
        final rgbString = await _computeRgbString();

        // Copy to clipboard
        await Clipboard.setData(ClipboardData(text: rgbString));

        if (mounted) {
          _showSuccessSnackBar('RGB copied!');
        }
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar('Failed to copy RGB');
        }
      } finally {
        if (mounted) {
          setState(() => _isRgbCopying = false);
        }
      }
    });
  }

  /// Copies the HEX value to clipboard with debouncing and feedback.
  Future<void> _copyHex() async {
    if (CopyLock.isLocked || _isHexCopying) return;

    // Activate lock instantly (same reasoning as in _copyRgb)
    CopyLock.lock(const Duration(milliseconds: 500));

    _hexDebounceTimer?.cancel();
    _hexDebounceTimer = Timer(const Duration(milliseconds: 200), () async {
      if (!mounted) return;

      setState(() => _isHexCopying = true);

      try {
        unawaited(HapticFeedback.lightImpact());
        final hexString = await _computeHexString();
        await Clipboard.setData(ClipboardData(text: hexString));

        if (mounted) {
          _showSuccessSnackBar('HEX copied!');
        }
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar('Failed to copy HEX');
        }
      } finally {
        if (mounted) {
          setState(() => _isHexCopying = false);
        }
      }
    });
  }

  /// Asynchronously computes the RGB string.
  Future<String> _computeRgbString() async {
    return Future.value(ColorUtils.toRgbString(widget.color));
  }

  /// Asynchronously computes the HEX string.
  Future<String> _computeHexString() async {
    return Future.value(ColorUtils.toHexString(widget.color));
  }

  /// Shows a success SnackBar.
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        duration: const Duration(milliseconds: 500),
        backgroundColor: Colors.green.withAlpha(230),
      ),
    );
  }

  /// Shows an error SnackBar.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.red.withAlpha(230),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withAlpha(76)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Color preview square
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withAlpha(128)),
            ),
          ),
          const SizedBox(width: 16),

          // Color info and copy buttons
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RGB row with copy button
                Tooltip(
                  message: 'Copy RGB',
                  child: CopyRow(
                    text: ColorUtils.toRgbString(widget.color),
                    onCopy: _copyRgb,
                    icon: Icons.copy,
                    tooltip: 'Copy RGB',
                    isLoading: _isRgbCopying,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // HEX row with copy button
                Tooltip(
                  message: 'Copy HEX',
                  child: CopyRow(
                    text: ColorUtils.toHexString(widget.color),
                    onCopy: _copyHex,
                    icon: Icons.copy,
                    tooltip: 'Copy HEX',
                    isLoading: _isHexCopying,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rgbDebounceTimer?.cancel();
    _hexDebounceTimer?.cancel();
    super.dispose();
  }
}

/// A reusable row widget containing text and a copy button.
class CopyRow extends StatelessWidget {
  /// Constructor for the CopyRow widget.
  const CopyRow({
    required this.text,
    required this.onCopy,
    required this.icon,
    required this.tooltip,
    required this.textStyle,
    this.isLoading = false,
    super.key,
  });

  /// The text to be displayed.
  final String text;

  /// Callback to be executed on copy action.
  final VoidCallback onCopy;

  /// Icon for the copy button.
  final IconData icon;

  /// Tooltip for the copy button.
  final String tooltip;

  /// Text styling.
  final TextStyle textStyle;

  /// Indicates whether the copy operation is in progress.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withAlpha(102)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withAlpha(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: isLoading ? null : onCopy, // Disable while loading
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isLoading
                      ? Colors.grey.withAlpha(64)
                      : Colors.grey.withAlpha(128),
                ),
                borderRadius: BorderRadius.circular(6),
                color: isLoading
                    ? Colors.grey.withAlpha(64)
                    : Colors.white.withAlpha(128),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    )
                  : Icon(icon, size: 18, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
