import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color/color_constant.dart';

class FilledButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  const FilledButtonWidget({
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1, // Efek shadow untuk memberikan tampilan "terangkat"
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
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
