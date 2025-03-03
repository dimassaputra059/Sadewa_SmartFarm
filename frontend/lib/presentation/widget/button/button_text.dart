import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../color/color_constant.dart';

class ButtonText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color defaultColor;

  const ButtonText({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14,
    this.defaultColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return ColorConstant.primary; // Warna saat ditekan
            }
            return defaultColor; // Warna default
          },
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent), // Hilangkan efek latar belakang saat ditekan
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
