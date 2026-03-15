import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/tokens/radius.dart';
import '../../core/tokens/spacing.dart';
import '../../core/tokens/shadows.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double opacity;
  final double blur;
  final double borderOpacity;
  final EdgeInsets padding;
  final bool showShadow;
  final Color tintColor;

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
    this.tintColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: tintColor.withAlpha((opacity * 255).round()),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: tintColor.withAlpha((borderOpacity * 255).round())),
            boxShadow: showShadow ? AppShadows.card : [],
          ),
          child: child,
        ),
      ),
    );
  }
}
