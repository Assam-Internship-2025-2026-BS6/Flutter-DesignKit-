import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Color activeColor;
  final Color labelColor;
  final double size;
  final double fontSize;
  final Offset offset;

  const ToggleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.activeColor = const Color(0xFF1E1E4C),
    this.labelColor = Colors.black87,
    this.size = 1.0,
    this.fontSize = 20.0,
    this.offset = Offset.zero,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> with SingleTickerProviderStateMixin {
  late bool _internalValue;

  @override
  void initState() {
    super.initState();
    _internalValue = widget.value;
  }

  @override
  void didUpdateWidget(ToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _internalValue = widget.value;
    }
  }

  void _handleTap() {
    if (widget.onChanged != null) {
      setState(() {
        _internalValue = !_internalValue;
      });
      widget.onChanged!(_internalValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaling and Offset
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
            child: Transform.scale(
              scale: widget.size,
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: _handleTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 50,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _internalValue ? widget.activeColor : Colors.grey.shade300,
                        boxShadow: [
                          if (_internalValue)
                            BoxShadow(
                              color: widget.activeColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: _internalValue ? 24 : 4,
                            top: 4,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.label != null) ...[
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          widget.label!,
                          style: TextStyle(
                            color: widget.labelColor,
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
