import 'package:flutter/material.dart' hide Text;
import '../atoms/text_field.dart' as dk;
import '../atoms/text.dart' as dk;
import '../../core/tokens/typography.dart';

class PasswordField extends StatelessWidget {
  final String label;
  final String hintText;
  final double? width;

  const PasswordField({
    super.key,
    required this.label,
    required this.hintText,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          isPassword: true,
          width: width,
        ),
      ],
    );
  }
}
