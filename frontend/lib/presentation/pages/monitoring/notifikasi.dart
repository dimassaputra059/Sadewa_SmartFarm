import 'package:flutter/material.dart';
import '../../widget/navigation/navigasi_monitoring.dart';
import '../../widget/background_widget.dart';
import 'riwayat_kualitas_air/riwayat_kualitas_air.dart';
import 'kontrol_pakan_aerator.dart';
import 'monitoirng_sensor/monitoring.dart';
import '../../widget/navigation/app_bar_widget.dart';
import '../../blocks/kolom_notifikasi.dart'; // Import NotifikasiWidget

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Notifikasi",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Konten Utama**
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            bottom: screenHeight * 0.10,
            child: Column(
              children: [
                Expanded(
                  child: KolomNotifikasi(), // Dibungkus dengan Expanded agar sesuai dengan tata letak
                ),
              ],
            ),
          ),

          // **Navigasi Monitoring dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiMonitoring(
              selectedIndex: 2,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Monitoring()),
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RiwayatKualitasAir()),
                  );
                } else if (index == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const KontrolPakanAerator()),
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
