import 'dart:ui';
import 'package:flutter/material.dart';

/// A centered image atom widget with optional shadow and offset support.
/// 
/// This widget provides a consistent way to display assets throughout 
/// the design kit, including fallback behavior for broken images.
class dkImage extends StatefulWidget {
  /// The path to the image asset.
  final String imagePath;

  /// The desired width of the image.
  final double? width;

  /// The desired height of the image.
  final double? height;

  /// Horizontal positional offset.
  final double offsetX;

  /// Vertical positional offset.
  final double offsetY;

  /// Whether to display a soft shadow beneath the image.
  final bool showShadow;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  const dkImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.showShadow = false,
    this.fit = BoxFit.contain,
  });

  @override
  State<dkImage> createState() => _dkImageState();
}

class _dkImageState extends State<dkImage> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      widget.imagePath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) => Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );

    return Transform.translate(
      offset: Offset(widget.offsetX, widget.offsetY),
      child: m.MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: m.AnimatedScale(
          scale: _isHovering ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.showShadow)
                Positioned.fill(
                  child: Transform.translate(
                    offset: Offset(0, _isHovering ? 10 : 6),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: _isHovering ? 15 : 10, 
                        sigmaY: _isHovering ? 15 : 10,
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: _isHovering ? 0.4 : 0.2),
                          BlendMode.srcIn,
                        ),
                        child: imageWidget,
                      ),
                    ),
                  ),
                ),
              if (_isHovering)
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF004C8F).withValues(alpha: 0.25), // HDFC Blue Halo
                        BlendMode.srcIn,
                      ),
                      child: imageWidget,
                    ),
                  ),
                ),
              imageWidget,
            ],
          ),
        ),
      ),
    );
  }
}
