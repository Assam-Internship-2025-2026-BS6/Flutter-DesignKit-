import 'package:flutter/material.dart';

class LoginTemplate extends StatelessWidget {
  final Widget leftSection;
  final Widget rightSection;
  final double width;
  final double height;
  final bool isFullScreen;

  const LoginTemplate({
    super.key,
    required this.leftSection,
    required this.rightSection,
    this.width = 1440,
    this.height = 900,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isFullScreen ? double.infinity : width,
          maxHeight: isFullScreen ? double.infinity : height,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 800;

            if (isMobile) {
              // On mobile, we use the full viewport height if the constraints allow it,
              // or fall back to the viewport height to ensure each "page" fills the screen.
              final viewportHeight = MediaQuery.of(context).size.height;
              final sectionHeight = constraints.maxHeight.isFinite && constraints.maxHeight > viewportHeight
                  ? constraints.maxHeight
                  : viewportHeight;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: sectionHeight,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: leftSection,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: sectionHeight,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: rightSection,
                    ),
                  ],
                ),
              );
            }

            return Row(
              children: [
                // Left Panel Slot
                Expanded(
                  flex: 1,
                  child: leftSection,
                ),
                // Right Panel Slot
                Expanded(
                  flex: 1,
                  child: rightSection,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
