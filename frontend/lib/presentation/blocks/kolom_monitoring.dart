import 'dart:async'; // ✅ Import Timer
import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import '../../server/api_service.dart';
import '../pages/monitoring/monitoirng_sensor/pengaturan_sensor.dart';
import '../widget/chart/chart_sensor.dart';

class KolomMonitoring extends StatefulWidget {
  final String pondId;
  final String namePond;
  final String sensorName;
  final String sensorType;
  final List<Map<String, dynamic>> sensorData; // 🔹 Data dummy
  const KolomMonitoring({
    super.key,
    required this.pondId,
    required this.sensorName,
    required this.sensorType,
    required this.sensorData,
    required this.namePond,
  });

  @override
  _KolomMonitoringState createState() => _KolomMonitoringState();
}

class _KolomMonitoringState extends State<KolomMonitoring> {
  bool isPressed = false;
  String sensorValue = "--";
  List<Map<String, dynamic>> currentData = []; // 🔹 Data yang ditampilkan di grafik
  int index = 0; // 🔹 Index untuk perulangan data dummy
  Timer? timer; // 🔹 Timer untuk update otomatis

  @override
  void initState() {
    super.initState();
    _fetchSensorValue(); // Ambil nilai awal sensor
    currentData = List.from(widget.sensorData); // Set data awal
    _startUpdatingData(); // 🔹 Mulai update otomatis
  }

  @override
  void dispose() {
    timer?.cancel(); // 🔹 Hentikan timer saat widget dihapus
    super.dispose();
  }

  /// **🔹 Fungsi untuk mengambil nilai sensor dari API**
  void _fetchSensorValue() async {
    Map<String, dynamic>? sensorData =
    await ApiService.getMonitoringData(widget.pondId, widget.sensorType);

    if (sensorData != null && sensorData.containsKey("sensor_data")) {
      setState(() {
        double rawValue = double.tryParse(sensorData["sensor_data"].toString()) ?? 0.0;
        sensorValue = rawValue.toStringAsFixed(1);
      });
    } else {
      setState(() {
        sensorValue = "Error";
      });
    }
  }

  /// **🔹 Fungsi untuk memperbarui data setiap 5 detik**
  void _startUpdatingData() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        // 🔹 Tambahkan data baru dari sensorData, gunakan index agar data berulang
        currentData.removeAt(0); // Hapus data pertama agar grafik bergerak
        currentData.add(widget.sensorData[index]); // Tambahkan data baru
        index = (index + 1) % widget.sensorData.length; // 🔁 Ulangi data jika habis
      });
    });
  }

  /// **🔹 Format nilai sensor berdasarkan `sensorType`**
  String formatSensorValue(String value, String sensorType) {
    double parsedValue = double.tryParse(value) ?? 0.0;
    String formattedValue = parsedValue.toStringAsFixed(1);

    if (sensorType == 'temperature') {
      return '$formattedValue °C';
    } else if (sensorType == 'salinity') {
      return '$formattedValue ppt';
    } else if (sensorType == 'turbidity') {
      return '$formattedValue NTU';
    } else {
      return formattedValue; // pH tetap tanpa satuan
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.05;
    double paddingValue = screenWidth * 0.03;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.3,
      decoration: BoxDecoration(
        color: const Color(0x80D9DCD6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 🔹 Nama Sensor
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTapDown: (_) => setState(() => isPressed = true),
              onTapUp: (_) {
                setState(() => isPressed = false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PengaturanSensor(
                      pondId: widget.pondId,
                      sensorName: widget.sensorName,
                      currentValue: sensorValue,
                      namePond: widget.namePond,
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: screenWidth * 0.5,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  color: isPressed ? ColorConstant.primary : const Color(0xFFD9DCD6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.sensorName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: isPressed ? Colors.white : ColorConstant.primary,
                  ),
                ),
              ),
            ),
          ),

          // 🔹 Nilai Sensor
          Positioned(
            right: paddingValue,
            top: screenHeight * 0.01,
            child: Text(
              formatSensorValue(sensorValue, widget.sensorType),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize * 1.2,
                color: ColorConstant.primary,
              ),
            ),
          ),

          // 🔹 Grafik Sensor yang terus bergerak
          Positioned(
            top: screenHeight * 0.08,
            left: paddingValue,
            right: paddingValue,
            bottom: screenHeight * 0.02,
            child: ChartSensor(sensorData: currentData), // ✅ Data diperbarui setiap 5 detik
          ),
        ],
      ),
    );
  }
}
