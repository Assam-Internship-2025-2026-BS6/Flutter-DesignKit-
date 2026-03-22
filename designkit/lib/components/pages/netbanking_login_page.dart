import 'package:flutter/material.dart';
import '../../core/tokens/colors.dart';
import '../../components/organisms/left_info_section.dart';
import '../../components/organisms/right_login_container.dart';
import '../templates/login_template.dart';

class NetBankingLoginPage extends StatelessWidget {
  final double width;
  final double height;
  final bool isFullScreen;

  final String title;
  final String subtitle;
  final String customerIdLabel;
  final String customerIdHint;
  final String passwordLabel;
  final String buttonText;
  final String qrText;
  final String qrSubtitle;
  final String leftImagePath;
  
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

  const NetBankingLoginPage({
    super.key,
    this.width = 1440,
    this.height = 900,
    this.isFullScreen = false,
    this.title = "Welcome to NetBanking",
    this.subtitle = "MADE DIGITAL BY",
    this.customerIdLabel = "Customer ID/User ID",
    this.customerIdHint = "Customer ID/ User ID",
    this.passwordLabel = "Password",
    this.buttonText = "Login",
    this.qrText = "Click to scan QR and login",
    this.qrSubtitle = "New HDFC Bank Early Access App Required",
    this.leftImagePath = 'assets/left_image.png',
    this.titleSize = 'Medium',
    this.titleColor = const Color(0xFF1E1E4C),
    this.subtitleSize = 'Medium',
    this.subtitleColor = const Color(0xFF1E1E4C),
    this.customerIdSize = 'Medium',
    this.customerIdColor = const Color(0xFF1E1E4C),
    this.passwordSize = 'Medium',
    this.passwordColor = const Color(0xFF1E1E4C),
    this.buttonSize = 'Medium',
    this.buttonColor = const Color(0xFF004C8F),
    this.qrTextSize = 'Medium',
    this.qrTextColor = const Color(0xFF1E1E4C),
    this.qrSubtitleSize = 'Medium',
    this.qrSubtitleColor = const Color(0xFF1E1E4C),
    this.checkboxSize = 'Medium',
    this.checkboxColor = const Color(0xFF1E1E4C),
  });

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      width: width,
      height: height,
      isFullScreen: isFullScreen,
      leftSection: LeftInfoSection(
        leftImagePath: leftImagePath,
      ),
      rightSection: RightLoginContainer(
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
    );
  }
}