import 'package:flutter/material.dart';
import '../blocks/main_header_widget.dart';
import '../widget/navigasi_beranda.dart';
import '../widget/background_widget.dart';
import 'manajemen_user.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
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
              "Ini Halaman Beranda",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),

          // **Navigasi Beranda dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiBeranda(
              selectedIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ManajemenUser()),
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
