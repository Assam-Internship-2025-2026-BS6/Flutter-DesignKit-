import 'package:flutter/material.dart' hide Text;
import '../atoms/text_field.dart' as dk;
import '../atoms/glass_card.dart' as dk;
import '../atoms/text_button.dart' as dk;
import '../atoms/login_button.dart' as dk;
import '../atoms/text.dart' as dk;
import '../atoms/checkbox.dart' as dk;
import '../atoms/image_atom.dart';
import '../molecules/qr_login.dart';
import '../molecules/digicart_security.dart';
import '../molecules/labeled_input_field.dart';
import '../molecules/password_field.dart';
import '../../core/tokens/colors.dart';
import '../../core/tokens/typography.dart';
import '../../core/tokens/spacing.dart';
import '../../core/tokens/radius.dart';

class LandingFormOrganism extends StatefulWidget {
  final double width;
  final double height;
  final Color tintColor;
  final VoidCallback? onSetResetPassword;
  final VoidCallback? onRegisterNow;

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

  const LandingFormOrganism({
    super.key,
    this.width = 550,
    this.height = 720,
    this.tintColor = const Color(0x33FFFFFF),
    this.onSetResetPassword,
    this.onRegisterNow,
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
    this.buttonColor = AppColors.hdfcBlue,
    this.qrTextSize = 'Medium',
    this.qrTextColor = const Color(0xFF1E1E4C),
    this.qrSubtitleSize = 'Medium',
    this.qrSubtitleColor = const Color(0xFF1E1E4C),
    this.checkboxSize = 'Medium',
    this.checkboxColor = const Color(0xFF1E1E4C),
  });

  @override
  State<LandingFormOrganism> createState() => _LandingFormOrganismState();
}

class _LandingFormOrganismState extends State<LandingFormOrganism> {
  bool _keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 500;
        final isVeryShort = constraints.maxHeight < 700;
        // Dynamically compute gap sizes based on available height
        final double gap = isVeryShort ? AppSpacing.xSmall : AppSpacing.medium;
        final double smallGap = isVeryShort ? AppSpacing.xxSmall : AppSpacing.xSmall;
        // Helper method to convert 'Small' / 'Large' sizes into a scale modifier
        double scale(String sz) {
          if (sz == 'Small') return 0.8;
          if (sz == 'Large') return 1.2;
          return 1.0;
        }

        final tScale = scale(widget.titleSize);
        final sScale = scale(widget.subtitleSize);
        final cidScale = scale(widget.customerIdSize);
        final pScale = scale(widget.passwordSize);
        final bScale = scale(widget.buttonSize);
        final qrScale = scale(widget.qrTextSize);
        final qrSubScale = scale(widget.qrSubtitleSize);
        final checkboxScale = scale(widget.checkboxSize);

        return Center(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Column(
              children: [
                // GlassCard takes all available space minus footer
                Expanded(
                  child: dk.GlassCard(
                    width: widget.width,
                    tintColor: widget.tintColor,
                    borderRadius: AppRadius.circular,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? AppSpacing.medium : AppSpacing.large,
                      vertical: isVeryShort ? AppSpacing.medium : AppSpacing.large,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// WELCOME HEADER
                        dk.Text(
                          text: widget.title,
                          fontSize: (isSmall ? AppTypography.fontLargePlus : AppTypography.fontH2) * tScale,
                          fontWeight: FontWeight.bold,
                          color: widget.titleColor,
                        ),

                        /// LOGO SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dk.Text(
                              text: widget.subtitle,
                              fontSize: (isSmall ? AppTypography.fontSmall : AppTypography.fontMedium) * sScale,
                              fontWeight: FontWeight.bold,
                              color: widget.subtitleColor,
                              letterSpacing: 0.5,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                dkImage(imagePath: 'assets/hdfc_logo.png', height: isSmall ? 15 : 18),
                                const SizedBox(width: 12),
                                dkImage(imagePath: 'assets/now_logo.png', height: isSmall ? 11 : 14),
                              ],
                            ),
                          ],
                        ),

                        /// QR SCANNER BOX
                        QrLogin(
                          title: widget.qrText,
                          subtitle: widget.qrSubtitle,
                          width: double.infinity,
                          height: isVeryShort ? 70 : 85,
                          imagePath: 'assets/qr_login.png',
                          opacity: 0.3,
                          textColor: widget.qrTextColor,
                          textScale: qrScale,
                          subtitleColor: widget.qrSubtitleColor,
                          subtitleScale: qrSubScale,
                        ),

                        /// INPUT SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabeledInputField(
                              label: widget.customerIdLabel,
                              hintText: widget.customerIdHint,
                              labelColor: widget.customerIdColor,
                              labelScale: cidScale,
                            ),
                            const SizedBox(height: 8),
                            dk.TextButton(
                              text: "Get Customer ID",
                              onPressed: () => debugPrint("Get Customer ID Pressed"),
                              color: widget.customerIdColor,
                              fontSize: (isSmall ? AppTypography.fontMedium : AppTypography.fontLarge) * cidScale,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PasswordField(
                              label: widget.passwordLabel,
                              hintText: "Password",
                              labelColor: widget.passwordColor,
                              labelScale: pScale,
                            ),
                            const SizedBox(height: 8),
                            dk.TextButton(
                              text: "Set/Reset Password",
                              onPressed: widget.onSetResetPassword ?? () => debugPrint("Set/Reset Password Pressed"),
                              color: widget.passwordColor,
                              fontSize: (isSmall ? AppTypography.fontMedium : AppTypography.fontLarge) * pScale,
                            ),
                          ],
                        ),

                        /// SECURITY BANNER
                        DigicartSecurity(
                          title: "Goodbye, Secure Text & Image",
                          subtitle: "Hello, Digicert Security",
                          imagePath: 'assets/lock.png',
                          width: double.infinity,
                          height: isVeryShort ? 70 : 85,
                          opacity: 0.3,
                          onTap: () => debugPrint("Digicart Security Tapped"),
                        ),

                        /// KEEP ME LOGGED IN
                        dk.Checkbox(
                          value: _keepMeLoggedIn,
                          label: "Keep me logged in",
                          size: (isSmall ? 0.45 : 0.6) * checkboxScale,
                          labelColor: widget.checkboxColor,
                          activeColor: widget.checkboxColor,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _keepMeLoggedIn = val;
                              });
                            }
                          },
                        ),

                        /// LOGIN BUTTON
                        dk.LoginButton(
                          text: widget.buttonText,
                          onTap: () => debugPrint("Login Pressed"),
                          width: double.infinity,
                          height: (isVeryShort ? 46.0 : 55.0) * bScale,
                          color: widget.buttonColor,
                          fontSize: 25.0 * bScale,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),

                /// FOOTER (Outside GlassCard)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     dk.Text(
                       text: "Not registered for NetBanking? ",
                       fontSize: (isSmall ? AppTypography.fontSmall : AppTypography.fontMedium) * bScale,
                       color: Colors.black87,
                     ),
                    dk.TextButton(
                      text: "Register Now",
                      onPressed: widget.onRegisterNow ?? () => debugPrint("Register Now Pressed"),
                      color: widget.buttonColor,
                      fontSize: (isSmall ? AppTypography.fontSmall : AppTypography.fontMedium) * bScale,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
