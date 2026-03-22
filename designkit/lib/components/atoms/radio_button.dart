import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;
  final Color activeColor;
  final Color labelColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double size;
  final Offset offset;

  const RadioButton({
    super.key,
    required this.value,
    this.onChanged,
    this.label = "Radio Option",
    this.activeColor = const Color(0xFF1E1E4C),
    this.labelColor = Colors.black87,
    this.fontSize = 28.0,
    this.fontWeight = FontWeight.normal,
    this.size = 1.0,
    this.offset = Offset.zero,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  bool _isFocused = false;

  void _handleTap() {
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.value;
    final double scaleFactor = widget.fontSize / 28.0;
    final double containerSize = 24.0 * scaleFactor;
    final double innerSize = 12.0 * scaleFactor;
    
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
            child: FocusableActionDetector(
              mouseCursor: SystemMouseCursors.click,
              onShowFocusHighlight: (value) {
                setState(() => _isFocused = value);
              },
              actions: {
                ActivateIntent: CallbackAction<ActivateIntent>(
                  onInvoke: (_) => _handleTap(),
                ),
              },
              child: GestureDetector(
                onTap: _handleTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: _isFocused
                        ? widget.activeColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: _isFocused
                        ? Border.all(color: widget.activeColor.withValues(alpha: 0.5), width: 1)
                        : null,
                  ),
                  child: Transform.scale(
                    scale: widget.size,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: containerSize,
                          height: containerSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? widget.activeColor : Colors.grey,
                              width: 2 * scaleFactor,
                            ),
                          ),
                          child: Center(
                            child: isSelected
                                ? Container(
                                    width: innerSize,
                                    height: innerSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.activeColor,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 12 * scaleFactor),
                        Flexible(
                          child: Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: widget.fontSize,
                              fontWeight: widget.fontWeight,
                              color: widget.labelColor,
                            ),
                          ),
                        ),
                      ],
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