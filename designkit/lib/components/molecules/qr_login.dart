import 'dart:ui';
import 'package:flutter/material.dart' hide Text;
import '../atoms/text.dart' as dk;
import '../atoms/image_atom.dart';
import '../atoms/glass_card.dart' as dk;
import '../../core/tokens/typography.dart';
import '../../core/tokens/colors.dart';

class QrLogin extends StatelessWidget {
  final String title;
  final String subtitle;
  final String popupTitle;
  final String qrData;
  final IconData icon;
  final String? imagePath;
  final Color accentColor;
  final double width;
  final double height;
  final double blur;
  final double opacity;
  final Offset offset;

  const QrLogin({
    super.key,
    required this.title,
    required this.subtitle,
    this.popupTitle = "Scan QR Code",
    this.qrData = "",
    this.icon = Icons.qr_code_2,
    this.imagePath,
    this.accentColor = Colors.black54,
    this.width = 484,
    this.height = 120,
    this.blur = 15,
    this.opacity = 0.2,
    this.offset = Offset.zero,
  });

  void _showQrPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dk.Text(
                    text: popupTitle,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: imagePath != null
                        ? dkImage(imagePath: imagePath!, width: 180, height: 180)
                        : Icon(icon, size: 180, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: dk.Text(
                      text: "Dismiss",
                      fontSize: AppTypography.fontLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isVerySmall = constraints.maxWidth < 450;
          
          return dk.GlassCard(
            width: width,
            height: height,
            blur: blur,
            opacity: opacity,
            borderRadius: 20,
            padding: EdgeInsets.symmetric(
              horizontal: isVerySmall ? 12 : 20,
              vertical: height < 80 ? 4 : 8,
            ),
            showShadow: false,
            tintColor: AppColors.grey,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showQrPopup(context),
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: [
                    if (height > 40) _buildIconTile(isVerySmall, height),
                    if (height > 40) SizedBox(width: isVerySmall ? 10 : 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          dk.Text(
                            text: title,
                            maxLines: 1,
                            fontSize: height < 50 ? AppTypography.fontSmall : (isVerySmall ? AppTypography.fontLarge : AppTypography.fontLargePlus),
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          if (height > 60) ...[
                            const SizedBox(height: 4),
                              dk.Text(
                                text: subtitle,
                                maxLines: height > 100 ? 2 : 1,
                                fontSize: isVerySmall ? AppTypography.fontSmall : AppTypography.fontMedium,
                                color: AppColors.black.withValues(alpha: 0.87),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconTile(bool isSmall, double containerHeight) {
    final double maxSize = (containerHeight - 16).clamp(20, 200);
    final double size = (isSmall ? 55.0 : 70.0).clamp(20, maxSize);
    final double iconSize = (size - 15).clamp(10, 45);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.5),
          width: 2.5,
        ),
      ),
      child: Center(
        child: imagePath != null
            ? dkImage(
                imagePath: imagePath!,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              )
            : Icon(
                icon,
                size: iconSize,
                color: accentColor,
              ),
      ),
    );
  }
}
