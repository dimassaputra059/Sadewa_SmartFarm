import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Lebar penuh sesuai layar
        height: double.infinity, // Tinggi penuh sesuai layar
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background-Apk.png"), // Path gambar
            fit: BoxFit.cover, // Menutupi seluruh layar secara proporsional
          ),
        ),
      ),
    );
  }
}
