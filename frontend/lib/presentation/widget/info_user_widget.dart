import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoUserWidget extends StatelessWidget {
  final String label;
  final String info;

  const InfoUserWidget({
    super.key,
    required this.label,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600, // SemiBold
            color: Colors.white
          ),
        ),

        // Info
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 6, left: 20), // Jarak antar teks
          child: Text(
            info,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400, // Regular
                color: Colors.white
            ),
          ),
        ),

        // Underline
        Container(
          width: 250,
          height: 1.5,
          color: Colors.white.withAlpha(128), // Warna garis dengan transparansi
        ),
      ],
    );
  }
}
