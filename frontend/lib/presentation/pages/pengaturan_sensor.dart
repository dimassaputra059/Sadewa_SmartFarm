import 'package:flutter/material.dart';
import '../widget/background_widget.dart';
import '../widget/edit_parameter.dart';
import '../widget/navigation/app_bar_widget.dart';
import '../widget/navigation/navigasi_monitoring.dart';
import 'monitoring/history.dart';
import 'monitoring/kontrol_pakan_aerator.dart';
import 'monitoring/notifikasi.dart';

class PengaturanSensor extends StatelessWidget {
  final String sensorName;
  final String currentValue;
  final String highestValue;
  final String lowestValue;
  final int initialHighValue;
  final int initialLowValue;

  const PengaturanSensor({
    super.key,
    required this.sensorName,
    required this.currentValue,
    required this.highestValue,
    required this.lowestValue,
    required this.initialHighValue,
    required this.initialLowValue,
  });

  // Fungsi untuk menentukan tipe sensor berdasarkan nama sensor
  String getSensorType() {
    switch (sensorName.toLowerCase()) {
      case "sensor suhu":
        return "suhu";
      case "sensor ph":
        return "ph";
      case "sensor salinitas":
        return "salinitas";
      case "sensor kekeruhan":
        return "kekeruhan";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Pengaturan - $sensorName",
        onBackPress: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Widget untuk Menampilkan dan Mengedit Parameter Sensor**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),

            child: EditParameterWidget(
              sensorName: sensorName,
              sensorType: getSensorType(), // Otomatis menyesuaikan sensorType
              currentValue: currentValue,
              highestValue: highestValue,
              lowestValue: lowestValue,
              initialHighValue: initialHighValue,
              initialLowValue: initialLowValue,
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
