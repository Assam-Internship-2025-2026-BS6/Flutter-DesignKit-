import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/tokens/radius.dart';
import '../../core/tokens/spacing.dart';
import '../../core/tokens/shadows.dart';

/// A reusable frosted glass card widget that applies a blur backdrop,
/// tinted background, optional border, shadow, and tap interaction.
///
/// Built using [BackdropFilter] + [ClipRRect] for the glass effect,
/// and [InkWell] inside [Material] for hover and tap ripple support.
///
/// Example usage:
/// ```dart
/// GlassCard(
///   width: 300,
///   height: 120,
///   tintColor: Colors.white,
///   onTap: () => print("tapped"),
///   child: Text("Hello"),
/// )
/// ```
class GlassCard extends StatefulWidget {
  /// The widget displayed inside the glass card.
  final Widget child;

  /// Width of the card. If null, card sizes to its content.
  final double? width;

  /// Height of the card. If null, card sizes to its content.
  final double? height;

  /// Corner radius of the card and its clipping boundary.
  final double borderRadius;

  /// Opacity of the [tintColor] fill.
  /// Range: 0.0 (fully transparent) to 1.0 (fully opaque).
  final double opacity;

  /// Strength of the background blur effect.
  /// Higher values produce a stronger frosted glass look.
  final double blur;

  /// Opacity of the card's border color.
  /// Range: 0.0 (invisible border) to 1.0 (fully opaque border).
  final double borderOpacity;

  /// Inner padding applied around the [child].
  final EdgeInsets padding;

  /// Whether to show the card's drop shadow.
  /// Uses [AppShadows.card] when true.
  final bool showShadow;

  /// Base color used for the glass tint and border.
  /// Actual fill and border colors are derived from this with [opacity]
  /// and [borderOpacity] respectively.
  final Color tintColor;

  /// Callback triggered when the card is tapped.
  /// Also activates hover highlight via [InkWell].
  /// If null, the card is non-interactive.
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = AppRadius.xLarge,
    this.opacity = 0.15,
    this.blur = 20,
    this.borderOpacity = 0.3,
    this.padding = const EdgeInsets.all(AppSpacing.large),
    this.showShadow = true,
    this.tintColor = const Color(0xFF3B82F6),
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedScale(
        scale: _isHovering ? 1.01 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          // Clips the blur and child to the rounded corners
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            // Applies the frosted glass blur to everything behind the card
            filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
            child: Material(
              // Transparent so the glass decoration shows through
              // Required for InkWell ripple and hover to render correctly
              color: Colors.transparent,
              child: InkWell(
                // Makes the entire card surface tappable with hover highlight
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: widget.width,
                  height: widget.height,
                  padding: widget.padding,
                    decoration: BoxDecoration(
                      // Tinted glass fill — opacity controls translucency
                      color: widget.tintColor.withAlpha(((_isHovering ? widget.opacity + 0.05 : widget.opacity) * 255).round()),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      // Subtle border using the same tint color at borderOpacity
                      border: Border.all(
                        color: widget.tintColor.withAlpha(
                          ((_isHovering ? widget.borderOpacity + 0.4 : widget.borderOpacity) * 255)
                              .round()
                              .clamp(0, 255),
                        ),
                        width: _isHovering ? 2.0 : 1.0,
                      ),
                      // Shadow is optional — disabled for flat/embedded cards
                      boxShadow: widget.showShadow 
                          ? [
                              BoxShadow(
                                color: Colors.black.withAlpha(_isHovering ? 40 : 20),
                                offset: Offset(0, _isHovering ? 12 : 8),
                                blurRadius: _isHovering ? 20 : 12,
                                spreadRadius: _isHovering ? 2 : 0,
                              ),
                              if (_isHovering)
                                BoxShadow(
                                  color: const Color(0xFF004C8F).withValues(alpha: 0.25), // HDFC Blue Halo
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                ),
                            ]
                          : [],
                    ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}