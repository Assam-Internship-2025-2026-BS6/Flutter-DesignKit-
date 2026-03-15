import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart' show StatelessWidget, Widget, BuildContext, Color, FontWeight, TextAlign, TextOverflow, TextStyle, Colors, Container, Alignment, Offset, Transform;
import '../../core/tokens/typography.dart';

class Text extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final double? letterSpacing;
  final Offset offset;

  const Text({
    super.key,
    required this.text,
    this.fontSize = AppTypography.fontH1,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.letterSpacing,
    this.offset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: m.Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: AppTypography.fontFamily,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
