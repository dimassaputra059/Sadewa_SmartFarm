import 'package:flutter/material.dart';
import '../widget/background_widget.dart';
import '../widget/navigation/app_bar_widget.dart';
import '../widget/navigation/navigasi_monitoring.dart';
import '../widget/sensor_info_widget.dart'; // Import SensorInfoWidget
import 'monitoring/history.dart';
import 'monitoring/kontrol_pakan_aerator.dart';
import 'monitoring/notifikasi.dart';

class InformasiSensor extends StatelessWidget {
  const InformasiSensor({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Informasi Sensor",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Konten Utama dalam SingleChildScrollView**
          Positioned(
            top: screenHeight * 0.0,
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            bottom: screenHeight * 0.10, // Batas bawah agar tidak tertutup navigasi
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SensorInfoWidget(
                    sensorTitle: "Sensor Suhu",
                    imagePath: "assets/images/Sensor-Suhu.png",
                    description:
                    "DS18B20 adalah sensor berbentuk probe yang dirancang untuk mengukur suhu dalam air. Sensor ini memiliki fitur tahan air (waterproof), sehingga sangat ideal untuk digunakan dalam pemantauan suhu air secara akurat.",
                    specifications: [
                      "Tegangan Operasi: 3 - 5.5VDC",
                      "Jenis Sensor: Dallas DS18B20",
                      "Jenis Output: Digital",
                      "Rentang Suhu: -55°C hingga +125°C"
                    ],
                    optimalRange:
                    "Udang tumbuh optimal pada suhu air antara 28°C hingga 32°C dan memiliki toleransi antara 26°C hingga 35°C.",
                  ),
                  const SizedBox(height: 20), // Jarak di bawah agar tidak tertutup navigasi
                ],
              ),
            ),
          ),

          // **Navigasi Monitoring dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiMonitoring(
              selectedIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const History()),
                  );
                } else if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Notif()),
                  );
                } else if (index == 3) {
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
