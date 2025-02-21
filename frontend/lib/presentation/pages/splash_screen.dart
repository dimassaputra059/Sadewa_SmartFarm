import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/widget/background_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Memanggil Background

          // Logo App
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/Logo-App.png",
                  width: MediaQuery.of(context).size.width * 0.6,
                ),

                // Text "Sadewa Smartfarm"
                Text(
                  "Sadewa Smartfarm",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600, // Semibold
                    color: Colors.white,
                  ),
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}
