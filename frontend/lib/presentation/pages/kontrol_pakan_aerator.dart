import 'package:flutter/material.dart';
import '../widget/navigasi_monitoring.dart';
import '../widget/background_widget.dart';
import 'history.dart';
import 'monitoring.dart';
import 'notifikasi.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // **Konten Utama**
          Center(
            child: Text(
              "Ini Halaman Kontrol",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // **Navigasi Monitoring dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiMonitoring(
              selectedIndex: 3, // Pastikan index sesuai halaman
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Monitoring()),
                  );
                }
                else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const History()),
                  );
                }
                else if (index == 2){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Notif()),
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
