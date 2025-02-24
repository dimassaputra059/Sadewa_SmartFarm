import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color defaultColor;
  final Color pressedColor;

  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14,
    this.defaultColor = Colors.white,
    this.pressedColor = const Color(0xFF3A7CA5),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return pressedColor; // Warna saat ditekan
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
