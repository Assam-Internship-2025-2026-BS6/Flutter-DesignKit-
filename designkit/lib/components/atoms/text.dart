import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart' show StatelessWidget, Widget, BuildContext, Color, FontWeight, TextAlign, TextStyle, Colors, Container, Offset, Transform;
import '../../core/tokens/typography.dart';

/// A design-system compliant text atom with built-in boundary management.
/// 
/// This widget handles positioning, wrapping, and constraint-based boundary 
/// clamping to ensure text stays within the safe UI area.
class Text extends StatefulWidget {
  /// The string to display.
  final String text;

  /// The size of the glyphs to use when painting the text.
  final double fontSize;

  /// The color to use when painting the text.
  final Color color;

  /// The typeface thickness to use when painting the text.
  final FontWeight fontWeight;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// The amount of space to add between each letter.
  final double? letterSpacing;

  /// The positional offset of the text block.
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
  State<Text> createState() => _TextState();
}

class _TextState extends State<Text> {
  bool _isHovering = false;

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
        final double dynMaxWidth =
            (canvasWidth - widget.offset.dx.abs()).clamp(0.0, double.infinity);
        final double dynMaxHeight =
            (canvasHeight - widget.offset.dy.abs()).clamp(0.0, double.infinity);

        // 2: Boundary clamping
        final double maxSafeDx = (canvasWidth - dynMaxWidth) / 2.0;
        final double maxSafeDy = (canvasHeight - dynMaxHeight) / 2.0;

        // Apply bounding constraints so negative/positive Y or X offsets are clamped safely
        final double clampedX = widget.offset.dx.clamp(-maxSafeDx, maxSafeDx);
        final double clampedY = widget.offset.dy.clamp(-maxSafeDy, maxSafeDy);

        return Transform.translate(
          offset: Offset(clampedX, clampedY),
          child: m.MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            cursor: SystemMouseCursors.click,
            child: m.AnimatedScale(
              scale: _isHovering ? 1.02 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: _isHovering ? 8.0 : 0.0,
                  vertical: _isHovering ? 2.0 : 4.0,
                ),
                decoration: BoxDecoration(
                  color: _isHovering
                      ? widget.color.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (_isHovering)
                      BoxShadow(
                        color: const Color(0xFF004C8F).withValues(alpha: 0.2), // HDFC Blue Halo
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                constraints: m.BoxConstraints(
                  maxWidth: dynMaxWidth,
                  maxHeight: dynMaxHeight,
                ),
                // 4: No overflow, no clipping - natural wrapping
                child: m.Text(
                  widget.text,
                  maxLines: widget.maxLines,
                  textAlign: widget.textAlign,
                  overflow: null, // removing clip/ellipsis so it stays fully visible
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: widget.color,
                    fontWeight: widget.fontWeight,
                    fontFamily: AppTypography.fontFamily,
                    letterSpacing: widget.letterSpacing,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
