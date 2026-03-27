import 'package:flutter/material.dart' hide Text;
import '../atoms/text_field.dart' as dk;
import '../atoms/text.dart' as dk;
import '../../core/tokens/typography.dart';

/// A specialized form molecule for obscured password input.
/// 
/// Supports symmetrical customization for both the label and input sections.
class PasswordField extends StatefulWidget {
  /// The label text to display above the input field.
  final String label;

  /// The placeholder text for the input field.
  final String hintText;

  /// The horizontal width of the component.
  final double? width;

  /// The positional offset of the entire component.
  final Offset offset;

  /// The color of the label text.
  final Color labelColor;

  /// The font size of the label text.
  final double labelFontSize;

  /// The font weight of the label text.
  final FontWeight labelWeight;

  /// The color of the input field text.
  final Color inputColor;

  /// The font size of the input field text.
  final double inputFontSize;

  /// The font weight of the input field text.
  final FontWeight inputWeight;

  /// Callback when the text changes.
  final ValueChanged<String>? onChanged;

  const PasswordField({
    super.key,
    required this.label,
    required this.hintText,
    this.width,
    this.offset = Offset.zero,
    this.labelColor = Colors.black,
    this.labelFontSize = AppTypography.fontMedium,
    this.labelWeight = FontWeight.normal,
    this.inputColor = Colors.black87,
    this.inputFontSize = AppTypography.fontLarge,
    this.inputWeight = FontWeight.normal,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.offset,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedScale(
          scale: _isHovering ? 1.01 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              dk.Text(
                text: widget.label,
                color: widget.labelColor,
                fontSize: widget.labelFontSize,
                fontWeight: widget.labelWeight,
              ),
              const SizedBox(height: 6),
              dk.TextField(
                hintText: widget.hintText,
                isPassword: true,
                width: widget.width != null && widget.width! > 850 ? 850 : widget.width,
                maxLength: 16,
                fontSize: widget.inputFontSize,
                fontWeight: widget.inputWeight,
                onChanged: widget.onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}