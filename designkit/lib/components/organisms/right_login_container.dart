import 'package:flutter/material.dart';
import '../../core/tokens/spacing.dart';
import 'landing_form.dart';

class RightLoginContainer extends StatelessWidget {
  final double? width;
  final double? height;

  const RightLoginContainer({
    super.key,
    this.width,
    this.height,
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