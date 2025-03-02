import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/autentikasi/login.dart';
import 'package:frontend_app/presentation/pages/autentikasi/reset_password.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

import '../../widget/background_widget.dart';
import '../../widget/input/placeholder_input.dart';
import '../../widget/input/otp_input_widget.dart';
import '../../widget/button/button_widget.dart';
import '../../widget/button/text_button_widget.dart';

class LupaPassword extends StatelessWidget {
  const LupaPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.1;
    final double gapSize = size.height * 0.02;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // **Judul Halaman**
                  Text(
                    "Lupa Password",
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.09,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Gap(gapSize),

                  // **Instruksi Input Email**
                  Text(
                    "Silahkan masukkan email anda",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Gap(gapSize * 1.5),

                  // **Input Email**
                  SizedBox(
                    width: size.width * 0.8,
                    child: const PlaceholderInputWidget(
                      label: "Email",
                      iconPath: "assets/icons/icon-email.png",
                    ),
                  ),
                  Gap(gapSize),

                  // **Tombol "Minta Kode OTP"**
                  SizedBox(
                    child: FilledButtonWidget(
                      text: "Minta Kode OTP",
                      onPressed: () {
                        // TODO: Implementasi permintaan OTP
                      },
                    ),
                  ),
                  const Gap(30),

                  // **Instruksi Input OTP**
                  Text(
                    "Silahkan masukkan kode OTP",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Gap(gapSize * 1.5),

                  // **Input OTP**
                  SizedBox(
                    width: size.width * 0.7,
                    child: const OTPInputWidget(),
                  ),
                  const Gap(20),

                  // **Tombol "Kirim Kode OTP"**
                  SizedBox(
                    child: FilledButtonWidget(
                      text: "Kirim Kode OTP",
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ));
                      },
                    ),
                  ),
                  const Gap(15),
                  // **Tombol "Kembali Login"**
                  TextButtonWidget(
                    text: 'Kembali Login ?',
                    fontSize: size.width * 0.045,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                    },
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
