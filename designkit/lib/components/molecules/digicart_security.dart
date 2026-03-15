import 'package:flutter/material.dart' hide Text;
import '../atoms/text.dart' as dk;
import '../atoms/glass_card.dart' as dk;
import '../atoms/image_atom.dart';
import '../../core/tokens/typography.dart';
import '../../core/tokens/colors.dart';

class DigicartSecurity extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final double width;
  final double height;
  final double blur;
  final double opacity;
  final VoidCallback? onTap;

  const DigicartSecurity({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.width = 484,
    this.height = 120,
    this.blur = 15,
    this.opacity = 0.2,
    this.onTap,
  });

  @override
  State<DigicartSecurity> createState() => _DigicartSecurityState();
}

class _DigicartSecurityState extends State<DigicartSecurity> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: dk.GlassCard(
            width: widget.width,
            height: widget.height,
            blur: widget.blur,
            opacity: widget.opacity,
            borderRadius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            showShadow: false,
            tintColor: AppColors.grey,
            child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dk.Text(
                          text: widget.title,
                          color: const Color(0xFF004C8F),
                          fontSize: 19,
                        ),
                        const SizedBox(height: 6),
                        dk.Text(
                          text: widget.subtitle,
                          color: const Color(0xFF004C8F),
                          fontWeight: FontWeight.bold,
                          fontSize: AppTypography.fontLargePlus,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: dkImage(imagePath: widget.imagePath),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
