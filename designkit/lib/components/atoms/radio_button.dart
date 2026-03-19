import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isSelected = value;
    final double scaleFactor = fontSize / 28.0;
    final double containerSize = 24.0 * scaleFactor;
    final double innerSize = 12.0 * scaleFactor;
    
    return Transform.translate(
      offset: offset,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!value);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Transform.scale(
              scale: size,
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
                        color: isSelected ? activeColor : Colors.grey,
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
                                color: activeColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 12 * scaleFactor),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: labelColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}