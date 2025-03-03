import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color borderColor;
  final Color textColor;

  const ButtonOutlined({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.borderColor = const Color(0xFF16425B), // Default border color
    this.textColor = const Color(0xFF16425B), // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null, // Lebar penuh jika isFullWidth true
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(Size.zero), // Tidak membatasi ukuran minimum
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: borderColor, width: 1), // Border
          ),
          foregroundColor: WidgetStateProperty.all(textColor), // Warna teks
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF81C3D7); // Warna berubah saat ditekan
              }
              return Colors.transparent; // Warna default
            },
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Sudut lebih halus
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
