import 'package:flutter/material.dart';

/// A customizable dropdown molecule with an optional label and glass effect.
/// 
/// Features a styled container with shadow, custom icon, and flexible scaling.
class Dropdown extends StatefulWidget {
  /// The currently selected value.
  final String? value;

  /// The list of items to display in the dropdown.
  final List<String> items;

  /// Callback when the selected value changes.
  final ValueChanged<String?>? onChanged;

  /// Optional label text to display above the dropdown.
  final String? label;

  /// Placeholder text when no value is selected.
  final String hint;

  /// The width of the dropdown container.
  final double width;

  /// The color of the arrow icon.
  final Color activeColor;

  /// The relative scale of the component.
  final double size;

  /// The positional offset of the component.
  final Offset offset;

  const Dropdown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.label,
    this.hint = "Select option",
    this.width = 200,
    this.activeColor = const Color(0xFF1E1E4C),
    this.size = 1.0,
    this.offset = Offset.zero,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.offset,
      child: Transform.scale(
        scale: widget.size,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Container(
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: widget.items.contains(_selectedValue) ? _selectedValue : null,
                  hint: Text(widget.hint, style: const TextStyle(color: Colors.black38, fontSize: 14)),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: widget.activeColor),
                  borderRadius: BorderRadius.circular(12),
                  dropdownColor: Colors.white.withOpacity(0.9), // Subtle glass effect
                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(newValue);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
