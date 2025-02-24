import 'package:flutter/material.dart';

import '../widget/background_widget.dart';
import '../widget/navigasi_beranda.dart';
import '../blocks/main_header_widget.dart'; // Import MainHeaderWidget
import 'beranda.dart';

class ManajemenUser extends StatelessWidget {
  const ManajemenUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // **Header Baru (Jam, Tanggal, Profile, Underline)**
          const Positioned(
            left: 0,
            right: 0,
            top: 35,
            child: MainHeaderWidget(),
          ),

          // **Konten Utama**
          Center(
            child: Text(
              "Ini Halaman Manajemen User",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // **Navigasi Beranda dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiBeranda(
              selectedIndex: 1,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Beranda()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
