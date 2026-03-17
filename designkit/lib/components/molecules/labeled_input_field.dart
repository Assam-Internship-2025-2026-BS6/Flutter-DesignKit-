import 'package:flutter/material.dart' hide Text;
import '../atoms/text_field.dart' as dk;
import '../atoms/text.dart' as dk;
import '../../core/tokens/typography.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final double? width;
  final Offset offset;

  const LabeledInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.width,
    this.offset = Offset.zero,
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
          color: Colors.black,
          fontSize: AppTypography.fontMedium,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 6),
        dk.TextField(
          hintText: hintText,
          width: width != null && width! > 850 ? 850 : width,
        ),
      ],
    ),
    );
  }
}
