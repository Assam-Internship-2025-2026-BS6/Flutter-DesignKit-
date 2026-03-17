import 'package:flutter/material.dart' hide TextField, Text;
import 'package:flutter/material.dart' as m show TextField, TextEditingController;
import 'package:flutter/services.dart';
import 'text.dart' as dk;
import '../../core/tokens/typography.dart';
import '../../core/tokens/colors.dart';
import '../../core/tokens/radius.dart';
import '../../core/tokens/spacing.dart';

class TextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final String? Function(String)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final double? height;
  final bool showErrorText;
  final Color textColor;
  final FontWeight fontWeight;
  final bool enabled;
  final Offset offset;

  const TextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.width,
    this.height = 60.0,
    this.showErrorText = true,
    this.textColor = AppColors.black,
    this.fontWeight = FontWeight.w500,
    this.enabled = true,
    this.offset = Offset.zero,
  });

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  final m.TextEditingController _controller = m.TextEditingController();
  bool _obscureText = true;
  String? _errorText;
  bool _isHovering = false;

  String? _validatePassword(String value) {

  if (value.trim().isEmpty) {
    return null;
  }

  if (value.length > 16) {
    return "Maximum 16 characters allowed";
  }

  if (value.length < 8) {
    return "Minimum 8 characters required";
  }

  final hasUppercase = value.contains(RegExp(r'[A-Z]'));
  final hasLowercase = value.contains(RegExp(r'[a-z]'));
  final hasDigits = value.contains(RegExp(r'[0-9]'));
  final hasSpecialCharacters =
      value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  if (!hasUppercase || !hasLowercase || !hasDigits || !hasSpecialCharacters) {
    return "Use mix of A-Z, a-z, 0-9 & symbols";
  }

  return null;
}

  void _validate(String value) {
    if (value.trim().isEmpty) {
      setState(() => _errorText = null);
      return;
    }
    String? error;

    // Only validate password if it's not empty, to avoid showing error on focus
    if (widget.isPassword && value.isNotEmpty) {
      error = _validatePassword(value);
    }

    if (error == null && widget.validator != null) {
      error = widget.validator!(value);
    }

    setState(() {
      _errorText = error;
    });
  }

  bool get hasError => _errorText != null;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.offset,
      child: SizedBox(
        width: widget.width != null && widget.width! > 850 ? 850 : widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: SizedBox(
                height: widget.height,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _isHovering
                        ? const Color(0x26FFFFFF).withValues(alpha: 0.1)
                        : const Color(0x26FFFFFF),
                    borderRadius: BorderRadius.circular(AppRadius.circular),
                    border: Border.all(
                      color: (hasError && widget.showErrorText) 
                          ? Colors.red 
                          : Colors.black.withValues(alpha: 0.2), // Darker border for visibility
                      width: 2.0, // Thicker border
                    ),
                  ),
                  child: Opacity(
                    opacity: widget.enabled ? 1.0 : 0.5,
                    child: m.TextField(
                        enabled: widget.enabled,
                        controller: _controller,
                        obscureText: widget.isPassword ? _obscureText : false,
                        maxLength: widget.maxLength,
                        inputFormatters: widget.inputFormatters,
                        onChanged: _validate,
                        style: TextStyle(
                          fontSize: AppTypography.fontLarge,
                          color: widget.textColor,
                          fontWeight: widget.fontWeight,
                          fontFamily: AppTypography.fontFamily,
                          height: 1.0,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: AppColors.black.withValues(alpha: 0.3),
                            fontSize: AppTypography.fontLarge,
                            fontFamily: AppTypography.fontFamily,
                            fontWeight: FontWeight.w500, // Slightly thicker hint text
                            height: 1.0,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.large,
                            vertical: 10.0,
                          ),
                          border: InputBorder.none,
                          suffixIcon: widget.isPassword
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.black87,
                                      size: 20,
                                    ),
                                    onPressed: widget.enabled ? () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    } : null,
                                  ),
                                )
                              : null,
                        ),
                      ),
                  ),
                  ),
              ),
            ),
            if (hasError && widget.showErrorText) ...[
              const SizedBox(height: 8),
               Padding(
                 padding: const EdgeInsets.only(left: AppSpacing.large),
                 child: dk.Text(
                   text: _errorText!,
                   color: Colors.red,
                   fontSize: AppTypography.fontMedium,
                   fontWeight: FontWeight.w500,
                 ),
               ),
            ],
          ],
        ),
      ),
    );
  }
}
