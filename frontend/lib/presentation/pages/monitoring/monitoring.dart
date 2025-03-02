import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/monitoring/kontrol_pakan_aerator.dart';
import '../../widget/navigation/app_bar_widget.dart';
import 'history.dart';
import 'notifikasi.dart';
import '../../widget/navigation/navigasi_monitoring.dart';
import '../../widget/background_widget.dart';
import '../../widget/monitoring_widget.dart'; // Import MonitoringWidget

class Monitoring extends StatelessWidget {
  const Monitoring({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // ** Data Dummy untuk Grafik Sensor **
    final List<Map<String, dynamic>> dummyTemperatureData = [
      {"time": "00:00", "value": 28.5},
      {"time": "03:00", "value": 29.0},
      {"time": "06:00", "value": 28.8},
      {"time": "09:00", "value": 29.2},
      {"time": "12:00", "value": 30.0},
      {"time": "15:00", "value": 29.5},
      {"time": "18:00", "value": 28.9},
      {"time": "21:00", "value": 28.7},
    ];

    final List<Map<String, dynamic>> dummyPHData = [
      {"time": "00:00", "value": 7.1},
      {"time": "03:00", "value": 7.3},
      {"time": "06:00", "value": 7.4},
      {"time": "09:00", "value": 7.2},
      {"time": "12:00", "value": 7.5},
      {"time": "15:00", "value": 7.4},
      {"time": "18:00", "value": 7.2},
      {"time": "21:00", "value": 7.3},
    ];

    final List<Map<String, dynamic>> dummySalinityData = [
      {"time": "00:00", "value": 30},
      {"time": "03:00", "value": 29.8},
      {"time": "06:00", "value": 30.2},
      {"time": "09:00", "value": 30.5},
      {"time": "12:00", "value": 30.1},
      {"time": "15:00", "value": 29.9},
      {"time": "18:00", "value": 30.3},
      {"time": "21:00", "value": 30.0},
    ];

    final List<Map<String, dynamic>> dummyTurbidityData = [
      {"time": "00:00", "value": 18},
      {"time": "03:00", "value": 17.5},
      {"time": "06:00", "value": 18.2},
      {"time": "09:00", "value": 18.5},
      {"time": "12:00", "value": 19.0},
      {"time": "15:00", "value": 18.3},
      {"time": "18:00", "value": 17.8},
      {"time": "21:00", "value": 18.1},
    ];

    return Scaffold(
      appBar: AppBarWidget(
        title: "Monitoring",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Konten Utama**
          Positioned(
            top: screenHeight * 0.0,
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            bottom: screenHeight * 0.10, // Tambahkan batas agar tidak menabrak navigasi
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  MonitoringWidget(
                    sensorName: 'Sensor Suhu',
                    sensorValue: ('29'), // Pisahkan angka & satuan
                    sensorData: dummyTemperatureData,
                  ),
                  const SizedBox(height: 10),
                  MonitoringWidget(
                    sensorName: 'Sensor pH',
                    sensorValue: ('7.4'), // pH tidak memerlukan satuan
                    sensorData: dummyPHData,
                  ),
                  const SizedBox(height: 10),
                  MonitoringWidget(
                    sensorName: 'Sensor Salinitas',
                    sensorValue: ('30'),
                    sensorData: dummySalinityData,
                  ),
                  const SizedBox(height: 10),
                  MonitoringWidget(
                    sensorName: 'Sensor Kekeruhan',
                    sensorValue: ('18'),
                    sensorData: dummyTurbidityData,
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
