import 'package:flutter/material.dart' hide Text;
import '../atoms/button.dart' as dk;
import '../atoms/text.dart' as dk;
import '../../core/tokens/colors.dart';
import '../../core/tokens/typography.dart';
import '../../core/tokens/spacing.dart';

class LeftInfoSection extends StatelessWidget {
  final double? width;
  final double? height;

  final String leftImagePath;
  final String textSize;
  final Color textColor;

  const LeftInfoSection({
    super.key,
    this.width,
    this.height,
    this.leftImagePath = 'assets/left_image.png',
    this.textSize = 'Medium',
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(leftImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;

          double textScale = 1.0;
          if (textSize == 'Small') textScale = 0.8;
          if (textSize == 'Large') textScale = 1.2;

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.none,
              horizontal: isSmall ? AppSpacing.large : AppSpacing.xxLarge,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Writing Part
                Column(
                  children: [
                    const SizedBox(height: 60),
                    dk.Text(
                      text: "Digital Arrest is Fake!",
                      textAlign: TextAlign.center,
                      fontSize: (isSmall ? AppTypography.fontH2 : AppTypography.fontExtraLarge) * textScale,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    const SizedBox(height: 10),
                    dk.Text(
                      text: "Genuine officers will never detain you\nor ask for money",
                      textAlign: TextAlign.center,
                      fontSize: (isSmall ? AppTypography.fontLarge : AppTypography.fontLargePlus) * textScale,
                      color: textColor.withAlpha(178), // 0.7 * 255
                    ),
                  ],
                ),
    
                // Bottom Writing Part & Know More Button
                Column(
                  children: [
                    dk.Text(
                      text: "When in doubt reach out to your bank.",
                      textAlign: TextAlign.center,
                      fontSize: (isSmall ? AppTypography.fontLarge : AppTypography.fontLargePlus) * textScale,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    const SizedBox(height: 8),
                    dk.Text(
                      text: "Click here to know more about Investment and APK Fraud",
                      textAlign: TextAlign.center,
                      fontSize: (isSmall ? AppTypography.fontMedium : AppTypography.fontLarge) * textScale,
                      color: textColor.withAlpha(153), // 0.6 * 255
                    ),
                    const SizedBox(height: 30),
                    
                    // Know More Button
                    dk.Button(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: dk.Text(text: "Loading detailed fraud prevention guide...", fontSize: 16),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      text: "Know More",
                      width: isSmall ? 250 : 350,
                      height: 55,
                      color: AppColors.hdfcBlue,
                      opacity: 0.8,
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // In standalone preview mode (explicit dimensions), center the component
    if (width != null && height != null) {
      return Center(child: content);
    }
    // Inside Expanded (NetBankingLoginPage), fill the parent
    return content;
  }
}

