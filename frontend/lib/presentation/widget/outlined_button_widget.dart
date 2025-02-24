import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color borderColor;
  final Color textColor;

  const OutlinedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.borderColor = const Color(0xFF16425B), // Default border color
    this.textColor = const Color(0xFF16425B), // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: isFullWidth
            ? WidgetStateProperty.all(const Size.fromHeight(36))
            : null,
        side: WidgetStateProperty.all(BorderSide(color: borderColor, width: 2)), // Border
        foregroundColor: WidgetStateProperty.all(textColor), // Warna teks
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return borderColor.withAlpha(75); // Warna saat tombol ditekan
            }
            return null;
          },
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: textColor, // Warna teks sesuai parameter
        ),
      ),
    );
  }
}
