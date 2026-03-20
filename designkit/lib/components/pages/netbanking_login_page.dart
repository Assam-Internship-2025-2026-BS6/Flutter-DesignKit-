import 'package:flutter/material.dart';
import '../../components/organisms/left_info_section.dart';
import '../../components/organisms/right_login_container.dart';
import '../templates/login_template.dart';

class NetBankingLoginPage extends StatelessWidget {
  final double width;
  final double height;
  final bool isFullScreen;

  // Added properties for customization
  final String? title;
  final String? subtitle;
  final String? customerIdLabel;
  final String? customerIdHint;
  final String? passwordLabel;
  final String? buttonText;
  final String? qrText;
  final String? qrSubtitle;
  final String? leftImagePath;
  
  final String? titleSize;
  final Color? titleColor;
  final String? subtitleSize;
  final Color? subtitleColor;
  final String? customerIdSize;
  final Color? customerIdColor;
  final String? passwordSize;
  final Color? passwordColor;
  final String? buttonSize;
  final Color? buttonColor;
  final double? buttonRadius;
  final String? qrTextSize;
  final Color? qrTextColor;
  final String? qrSubtitleSize;
  final Color? qrSubtitleColor;
  final String? checkboxSize;
  final Color? checkboxColor;

  const NetBankingLoginPage({
    super.key,
    this.width = 1440,
    this.height = 900,
    this.isFullScreen = false,
    this.title,
    this.subtitle,
    this.customerIdLabel,
    this.customerIdHint,
    this.passwordLabel,
    this.buttonText,
    this.qrText,
    this.qrSubtitle,
    this.leftImagePath,
    this.titleSize,
    this.titleColor,
    this.subtitleSize,
    this.subtitleColor,
    this.customerIdSize,
    this.customerIdColor,
    this.passwordSize,
    this.passwordColor,
    this.buttonSize,
    this.buttonColor,
    this.buttonRadius,
    this.qrTextSize,
    this.qrTextColor,
    this.qrSubtitleSize,
    this.qrSubtitleColor,
    this.checkboxSize,
    this.checkboxColor,
  });

  @override
  Widget build(BuildContext context) {
    return LoginTemplate(
      width: width,
      height: height,
      isFullScreen: isFullScreen,
      leftSection: const LeftInfoSection(),
      rightSection: const RightLoginContainer(),
    );
  }
}