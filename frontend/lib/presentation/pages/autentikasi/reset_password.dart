import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../widget/background_widget.dart';
import '../../widget/button/button_widget.dart';
import '../../widget/input/placeholder_input.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.1;
    final double gapSize = size.height * 0.02;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),

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
                      fontSize: size.width * 0.09,
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
                      fontSize: size.width * 0.045,
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
                    width: size.width * 0.5,
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
