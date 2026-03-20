import 'package:flutter/material.dart';
import '../../core/tokens/spacing.dart';
import 'landing_form.dart';

class RightLoginContainer extends StatelessWidget {
  final double? width;
  final double? height;

  final String title;
  final String subtitle;
  final String customerIdLabel;
  final String customerIdHint;
  final String passwordLabel;
  final String buttonText;
  final String qrText;
  final String qrSubtitle;
  
  final String titleSize;
  final Color titleColor;
  final String subtitleSize;
  final Color subtitleColor;
  final String customerIdSize;
  final Color customerIdColor;
  final String passwordSize;
  final Color passwordColor;
  final String buttonSize;
  final Color buttonColor;
  final String qrTextSize;
  final Color qrTextColor;
  final String qrSubtitleSize;
  final Color qrSubtitleColor;
  final String checkboxSize;
  final Color checkboxColor;

  const RightLoginContainer({
    super.key,
    this.width,
    this.height,
    this.title = "Welcome to NetBanking",
    this.subtitle = "MADE DIGITAL BY",
    this.customerIdLabel = "Customer ID/User ID",
    this.customerIdHint = "Customer ID/ User ID",
    this.passwordLabel = "Password",
    this.buttonText = "Login",
    this.qrText = "Click to scan QR and login",
    this.qrSubtitle = "New HDFC Bank Early Access App Required",
    this.titleSize = 'Medium',
    this.titleColor = const Color(0xFF1E1E4C),
    this.subtitleSize = 'Medium',
    this.subtitleColor = const Color(0xFF1E1E4C),
    this.customerIdSize = 'Medium',
    this.customerIdColor = const Color(0xFF1E1E4C),
    this.passwordSize = 'Medium',
    this.passwordColor = const Color(0xFF1E1E4C),
    this.buttonSize = 'Medium',
    this.buttonColor = const Color(0xFF1E1E4C),
    this.qrTextSize = 'Medium',
    this.qrTextColor = const Color(0xFF1E1E4C),
    this.qrSubtitleSize = 'Medium',
    this.qrSubtitleColor = const Color(0xFF1E1E4C),
    this.checkboxSize = 'Medium',
    this.checkboxColor = const Color(0xFF1E1E4C),
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/right_back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
                child: LandingFormOrganism(
                  width: constraints.maxWidth * 0.85, // Slightly wider form
                  height: constraints.maxHeight * 0.95, // Slightly taller form
                  tintColor: const Color(0x33FFFFFF),
                  title: title,
                  subtitle: subtitle,
                  customerIdLabel: customerIdLabel,
                  customerIdHint: customerIdHint,
                  passwordLabel: passwordLabel,
                  buttonText: buttonText,
                  qrText: qrText,
                  qrSubtitle: qrSubtitle,
                  titleSize: titleSize,
                  titleColor: titleColor,
                  subtitleSize: subtitleSize,
                  subtitleColor: subtitleColor,
                  customerIdSize: customerIdSize,
                  customerIdColor: customerIdColor,
                  passwordSize: passwordSize,
                  passwordColor: passwordColor,
                  buttonSize: buttonSize,
                  buttonColor: buttonColor,
                  qrTextSize: qrTextSize,
                  qrTextColor: qrTextColor,
                  qrSubtitleSize: qrSubtitleSize,
                  qrSubtitleColor: qrSubtitleColor,
                  checkboxSize: checkboxSize,
                  checkboxColor: checkboxColor,
                ),
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