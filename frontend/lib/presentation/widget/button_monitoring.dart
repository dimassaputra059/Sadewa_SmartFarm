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
    return SizedBox(
      width: isFullWidth ? double.infinity : null, // Lebar penuh jika isFullWidth true
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.zero, // Tidak membatasi ukuran minimum
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4), // Padding kecil
          side: BorderSide(color: borderColor, width: 1), // Border
          foregroundColor: textColor, // Warna teks
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Sudut lebih halus
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
