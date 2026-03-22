import 'package:flutter/material.dart' hide Text;
import '../atoms/text_field.dart' as dk;
import '../atoms/text.dart' as dk;
import '../../core/tokens/typography.dart';

/// A specialized form molecule for obscured password input.
/// 
/// Combines a bold label with a [dk.TextField] configured with [isPassword] enabled.
class PasswordField extends StatelessWidget {
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

  /// The scale factor applied to the label font size.
  final double labelScale;

  const PasswordField({
    super.key,
    required this.label,
    required this.hintText,
    this.width,
    this.offset = Offset.zero,
    this.labelColor = Colors.black,
    this.labelScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        dk.Text(
          text: label,
          color: labelColor,
          fontSize: AppTypography.fontMedium * labelScale,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 6),
        dk.TextField(
          hintText: hintText,
          isPassword: true,
          width: width != null && width! > 850 ? 850 : width,
          maxLength: 16,
        ),
      ],
    ),
    );
  }
}