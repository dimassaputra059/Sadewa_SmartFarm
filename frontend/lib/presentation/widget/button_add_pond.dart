import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color/color_constant.dart';

class ButtonAddPond extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  const ButtonAddPond({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null, // Jika full width, lebar maksimal
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.primary, // Warna tombol utama
          foregroundColor: Colors.white, // Warna teks
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6), // Padding sama dengan FilledButtonWidget
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Border radius sama
          ),
          elevation: 1, // Efek shadow
          minimumSize: const Size(0, 0),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF3A7CA5); // Warna saat tombol ditekan
              }
              return null;
            },
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 13, // Font size sama dengan FilledButtonWidget
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
