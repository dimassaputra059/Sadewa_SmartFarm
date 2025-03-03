import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class InputStandart extends StatelessWidget {
  final String label;
  final bool isPassword;

  const InputStandart({super.key, required this.label, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Ambil ukuran layar

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // **Label teks di atas input (responsif)**
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.04, // Sekitar 4.5% dari lebar layar
            fontWeight: FontWeight.w600, // SemiBold
            color: Colors.white, // Warna teks label
          ),
        ),
        const Gap(8), // Jarak antara label dan input field

        // **Input field dengan tinggi responsif (minimal 40)**
        SizedBox(
          height: size.height * 0.05 < 40 ? 40 : size.height * 0.05,
          child: TextField(
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.04, // Sekitar 4% dari lebar layar
              color: Colors.white, // Warna teks dalam input
            ),
            obscureText: isPassword, // Menyembunyikan teks jika isPassword = true
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.012, horizontal: size.width * 0.03), // Padding responsif
              fillColor: Colors.transparent, // Background transparan
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.025), // Border melengkung responsif
                borderSide: const BorderSide(color: Colors.white), // Warna border default (Putih)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.025),
                borderSide: const BorderSide(color: Color(0xFF3A7CA5)), // Warna border saat fokus
              ),
            ),
            cursorColor: Colors.white, // Warna kursor
          ),
        ),
        const Gap(20), // Jarak setelah input field
      ],
    );
  }
}
