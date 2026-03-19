import 'package:flutter/material.dart' hide TextButton;
import 'package:flutter/material.dart' as m show Text;

class TextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double fontSize;
  final bool isClickable;
  final bool enableHover;
  final Offset offset;

  const TextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize = 40,
    this.isClickable = true,
    this.enableHover = true,
    this.offset = Offset.zero,
  });

  @override
  State<TextButton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.color ?? const Color(0xFF283097);
    final bool effectiveClickable = widget.isClickable;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double canvasWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 1440.0;
        final double canvasHeight =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 1024.0;

        final double dynMaxWidth =
            (canvasWidth - widget.offset.dx.abs()).clamp(0.0, double.infinity);
        final double dynMaxHeight =
            (canvasHeight - widget.offset.dy.abs()).clamp(0.0, double.infinity);

        final double maxSafeDx = (canvasWidth - dynMaxWidth) / 2.0;
        final double maxSafeDy = (canvasHeight - dynMaxHeight) / 2.0;

        final double clampedX = widget.offset.dx.clamp(-maxSafeDx, maxSafeDx);
        final double clampedY = widget.offset.dy.clamp(-maxSafeDy, maxSafeDy);

        return Transform.translate(
          offset: Offset(clampedX, clampedY),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: dynMaxWidth,
              maxHeight: dynMaxHeight,
            ),
            child: MouseRegion(
              cursor: effectiveClickable
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              onEnter: (_) {
                if (widget.enableHover && effectiveClickable) {
                  setState(() => _isHovering = true);
                }
              },
              onExit: (_) {
                if (widget.enableHover && effectiveClickable) {
                  setState(() => _isHovering = false);
                }
              },
              child: GestureDetector(
                onTap: effectiveClickable ? widget.onPressed : null,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 150),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.fontSize,
                    height: 1.0,
                    letterSpacing: 0,
                    color: _isHovering
                        ? baseColor.withValues(alpha: 0.8)
                        : baseColor,
                    decoration: _isHovering && widget.enableHover
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  child: m.Text(widget.text), // Text bounded naturally
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
