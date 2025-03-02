import 'package:flutter/material.dart';
import '../../widget/navigation/navigasi_monitoring.dart';
import '../../widget/background_widget.dart';
import 'history.dart';
import 'kontrol_pakan_aerator.dart';
import 'monitoring.dart';
import '../../widget/navigation/app_bar_widget.dart';
import '../../widget/notifikasi_widget.dart'; // Import NotifikasiWidget

class Notif extends StatelessWidget {
  const Notif({super.key});

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
            top: screenHeight * 0.04,
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            bottom: screenHeight * 0.10,
            child: Column(
              children: [
                Expanded(
                  child: NotifikasiWidget(), // Dibungkus dengan Expanded agar sesuai dengan tata letak
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
                    MaterialPageRoute(builder: (context) => const History()),
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
