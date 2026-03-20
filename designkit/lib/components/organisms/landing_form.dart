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

  const LandingFormOrganism({
    super.key,
    this.width = 550,
    this.height = 720,
    this.tintColor = const Color(0x33FFFFFF),
    this.onSetResetPassword,
    this.onRegisterNow,
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
                          text: "Welcome to NetBanking",
                          fontSize: isSmall ? AppTypography.fontLargePlus : AppTypography.fontH2,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hdfcBlue,
                        ),

                        /// LOGO SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dk.Text(
                              text: "MADE DIGITAL BY",
                              fontSize: isSmall ? AppTypography.fontSmall : AppTypography.fontMedium,
                              fontWeight: FontWeight.bold,
                              color: AppColors.hdfcBlue,
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
                          title: "Click to scan QR and login",
                          subtitle: "New HDFC Bank Early Access App Required",
                          width: double.infinity,
                          height: isVeryShort ? 70 : 85,
                          imagePath: 'assets/qr_login.png',
                          opacity: 0.3,
                        ),

                        /// INPUT SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabeledInputField(
                              label: "Customer ID/User ID",
                              hintText: "Customer ID/ User ID",
                            ),
                            const SizedBox(height: 8),
                            dk.TextButton(
                              text: "Get Customer ID",
                              onPressed: () => debugPrint("Get Customer ID Pressed"),
                              color: AppColors.accentBlue,
                              fontSize: isSmall ? AppTypography.fontMedium : AppTypography.fontLarge,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const PasswordField(
                              label: "Password",
                              hintText: "Password",
                            ),
                            const SizedBox(height: 8),
                            dk.TextButton(
                              text: "Set/Reset Password",
                              onPressed: widget.onSetResetPassword ?? () => debugPrint("Set/Reset Password Pressed"),
                              color: AppColors.accentBlue,
                              fontSize: isSmall ? AppTypography.fontMedium : AppTypography.fontLarge,
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
                          size: isSmall ? 0.45 : 0.6,
                          labelColor: Colors.black87,
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
                          onTap: () => debugPrint("Login Pressed"),
                          width: double.infinity,
                          height: isVeryShort ? 46 : 55,
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
                       fontSize: isSmall ? AppTypography.fontSmall : AppTypography.fontMedium,
                       color: Colors.black87,
                     ),
                    dk.TextButton(
                      text: "Register Now",
                      onPressed: widget.onRegisterNow ?? () => debugPrint("Register Now Pressed"),
                      color: AppColors.hdfcBlue,
                      fontSize: isSmall ? AppTypography.fontSmall : AppTypography.fontMedium,
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