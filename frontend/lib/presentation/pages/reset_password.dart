import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widget/background_widget.dart';
import '../widget/button_widget.dart';
import '../widget/placeholder_input.dart';
import 'login.dart'; // Import halaman login untuk navigasi
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Mengambil ukuran layar
    final double paddingHorizontal = size.width * 0.1; // 8% dari lebar layar
    final double gapSize = size.height * 0.02; // 2% dari tinggi layar

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // Konten utama
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // **Judul Reset Password**
                  Text(
                    "Reset Password",
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.09, // Responsif berdasarkan lebar layar
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(gapSize),

                  // **Deskripsi**
                  Text(
                    "Silahkan masukkan password baru",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.045, // Responsif berdasarkan lebar layar
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Gap(gapSize * 1.5),

                  // **Input Password Baru**
                  const PlaceholderInputWidget(
                    label: "Password",
                    iconPath: "assets/icons/icon-password.png",
                    isPassword: true,
                  ),
                  Gap(gapSize),

                  // **Input Konfirmasi Password**
                  const PlaceholderInputWidget(
                    label: "Confirm Password",
                    iconPath: "assets/icons/icon-password.png",
                    isPassword: true,
                  ),
                  Gap(gapSize * 2),

                  // **Tombol Simpan**
                  SizedBox(
                    width: size.width * 0.5, // Ubah lebar sesuai kebutuhan
                    child: FilledButtonWidget(
                      text: 'Simpan',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
