import 'package:flutter/material.dart' hide Text;
import 'text.dart' as dk;
import '../../core/tokens/colors.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final Color color;
  final bool disabled;
  final double opacity;
  final Offset offset;

  const Button({
    super.key,
    required this.text,
    this.onTap,
    this.width = 150.0,
    this.height = 50.0,
    this.color = AppColors.hdfcBlue,
    this.disabled = false,
    this.opacity = 1.0,
    this.offset = Offset.zero,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled) {
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.disabled) {
      _animationController.reverse();
      widget.onTap?.call();
    }
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Opacity(
              opacity: widget.disabled ? 0.5 : widget.opacity,
              child: GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: widget.width > dynMaxWidth ? dynMaxWidth : widget.width,
                    height: widget.height > dynMaxHeight ? dynMaxHeight : widget.height,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(widget.height / 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: dk.Text(
                      text: widget.text,
                      color: AppColors.white,
                      fontSize: widget.height * 0.4, // Responsive font size based on height
                      fontWeight: FontWeight.bold,
                    ),
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
