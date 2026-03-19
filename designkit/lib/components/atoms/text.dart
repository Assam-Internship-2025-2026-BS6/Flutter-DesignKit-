import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart' show StatelessWidget, Widget, BuildContext, Color, FontWeight, TextAlign, TextStyle, Colors, Container, Offset, Transform;
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
    return m.LayoutBuilder(
      builder: (context, constraints) {
        // Fallback dimensions if unconstrained (e.g., infinity)
        final double canvasWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 1440.0;
        final double canvasHeight =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 1024.0;

        // 1 & 3: Reflow-aware wrapping & dynamic max-width/max-height
        // `availableWidth = canvasWidth - abs(xOffset)` shrinks wrap width automatically
        final double dynMaxWidth =
            (canvasWidth - offset.dx.abs()).clamp(0.0, double.infinity);
        final double dynMaxHeight =
            (canvasHeight - offset.dy.abs()).clamp(0.0, double.infinity);

        // 2: Boundary clamping
        // Text block must be fully contained within the preview screen.
        // We find the safe offset bounds. Since the parent centers the widget:
        // It starts at the center. Max distance it can shift without overflowing is half of the remaining canvas space.
        final double maxSafeDx = (canvasWidth - dynMaxWidth) / 2.0;
        final double maxSafeDy = (canvasHeight - dynMaxHeight) / 2.0;

        // Apply bounding constraints so negative/positive Y or X offsets are clamped safely
        final double clampedX = offset.dx.clamp(-maxSafeDx, maxSafeDx);
        final double clampedY = offset.dy.clamp(-maxSafeDy, maxSafeDy);

        return Transform.translate(
          offset: Offset(clampedX, clampedY),
          child: Container(
            constraints: m.BoxConstraints(
              maxWidth: dynMaxWidth,
              maxHeight: dynMaxHeight,
            ),
            // 4: No overflow, no clipping - natural wrapping
            child: m.Text(
              text,
              maxLines: maxLines,
              textAlign: textAlign,
              overflow: null, // removing clip/ellipsis so it stays fully visible
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
                fontFamily: AppTypography.fontFamily,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
        );
      },
    );
  }
}
