import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/kontrol_pakan_aerator.dart';
import 'history.dart';
import 'notifikasi.dart';
import '../widget/navigasi_monitoring.dart';
import '../widget/background_widget.dart';

class Monitoring extends StatelessWidget {
  const Monitoring({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // **Konten Utama**
          Center(
            child: Text(
              "Ini Halaman Monitoring",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // **Navigasi Monitoring dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiMonitoring(
              selectedIndex: 0, // Pastikan index sesuai halaman
              onTap: (index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const History()),
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
