import 'package:flutter/material.dart';
import '../widget/navigasi_monitoring.dart';
import '../widget/background_widget.dart';
import 'kontrol_pakan_aerator.dart';
import 'monitoring.dart';
import 'notifikasi.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // **Konten Utama**
          Center(
            child: Text(
              "Ini Halaman History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // **Navigasi Monitoring dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiMonitoring(
              selectedIndex: 1, // Pastikan index sesuai halaman
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Monitoring()),
                  );
                }
                else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Notif()),
                  );
                }
                else if (index == 3){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Control()),
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
