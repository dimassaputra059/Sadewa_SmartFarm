import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import '../../server/api_service.dart';
import '../pages/monitoring/monitoirng_sensor/pengaturan_sensor.dart';
import '../widget/chart/chart_sensor.dart';

class KolomMonitoring extends StatefulWidget {
  final String pondId;
  final String namePond;
  final String sensorName; // Nama tampilan sensor
  final String sensorType; // 🔹 Sensor Type untuk API Path
  final List<Map<String, dynamic>> sensorData; // Data untuk chart

  const KolomMonitoring({
    super.key,
    required this.pondId,
    required this.sensorName,
    required this.sensorType, // 🔹 Tambahkan sensorType
    required this.sensorData,
    required this.namePond,
  });

  @override
  _KolomMonitoringState createState() => _KolomMonitoringState();
}

class _KolomMonitoringState extends State<KolomMonitoring> {
  bool isPressed = false;
  String sensorValue = "--"; // 🔹 Nilai default sebelum API merespons

  @override
  void initState() {
    super.initState();
    _fetchSensorValue(); // 🔹 Ambil data saat widget pertama kali dibuat
  }

  /// **🔹 Fungsi untuk mengambil data sensor dari API**
  void _fetchSensorValue() async {
    Map<String, dynamic>? sensorData =
    await ApiService.getMonitoringData(widget.pondId, widget.sensorType);

    if (sensorData != null && sensorData.containsKey("sensor_data")) {
      setState(() {
        double rawValue = double.tryParse(sensorData["sensor_data"].toString()) ?? 0.0;
        sensorValue = rawValue.toStringAsFixed(1); // ✅ Format ke 1 angka di belakang koma
      });
    } else {
      setState(() {
        sensorValue = "Error"; // 🔹 Jika gagal mengambil data
      });
    }
  }

  /// **🔹 Format nilai sensor berdasarkan `sensorType`**
  String formatSensorValue(String value, String sensorType) {
    double parsedValue = double.tryParse(value) ?? 0.0; // ✅ Konversi ke double
    String formattedValue = parsedValue.toStringAsFixed(1); // ✅ Tetap 1 angka desimal

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
    double boxHeight = screenHeight * 0.3;
    double fontSize = screenWidth * 0.05;
    double paddingValue = screenWidth * 0.03;

    return Container(
      width: screenWidth * 0.9,
      height: boxHeight,
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
          // 🔹 Box Background untuk Sensor Name
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
                      namePond: widget.namePond, // ✅ Pastikan nilai sensor terbaru dikirim
                    ),
                  ),
                );
              },
              onTapCancel: () => setState(() => isPressed = false),
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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
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

          // 🔹 Sensor Value dari API
          Positioned(
            right: paddingValue,
            top: screenHeight * 0.01,
            child: Text(
              formatSensorValue(sensorValue, widget.sensorType), // ✅ Format berdasarkan sensorType
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize * 1.2,
                color: ColorConstant.primary,
              ),
            ),
          ),

          // 🔹 Garis Pemisah
          Positioned(
            top: screenHeight * 0.05,
            right: paddingValue,
            child: Container(
              width: screenWidth * 0.2,
              height: 1,
              color: const Color(0xFFD9DCD6),
            ),
          ),

          // 🔹 Grafik Sensor
          Positioned(
            top: screenHeight * 0.08,
            left: paddingValue,
            right: paddingValue,
            bottom: screenHeight * 0.02,
            child: ChartSensor(sensorData: widget.sensorData),
          ),
        ],
      ),
    );
  }
}
