import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend_app/presentation/pages/login.dart';
import 'package:frontend_app/presentation/widget/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigasi ke halaman login setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsif

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Background

          // Konten di tengah layar
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Aplikasi
                Image.asset(
                  "assets/images/Logo-App.png",
                  width: size.width * 0.6, // Responsif terhadap layar
                ),

                const SizedBox(height: 10),

                // Nama Aplikasi
                Text(
                  "Sadewa Smartfarm",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.07, // Responsif terhadap layar
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
