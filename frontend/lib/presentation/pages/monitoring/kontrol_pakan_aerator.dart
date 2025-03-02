import 'package:flutter/material.dart';
import '../../blocks/kontrol_aerator.dart';
import '../../blocks/kontrol_pakan.dart';
import '../../widget/navigation/app_bar_widget.dart';
import '../../widget/navigation/navigasi_monitoring.dart';
import '../../widget/background_widget.dart';
import 'history.dart';
import 'monitoring.dart';
import 'notifikasi.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Kontrol Pakan & Aerator",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Konten Utama dengan ScrollView agar tidak tertutup navigasi**
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 60.0), // Hindari overlap dengan navigasi
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    KontrolPakan(),
                    SizedBox(height: 24),
                    KontrolAerator(),
                  ],
                ),
              ),
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
