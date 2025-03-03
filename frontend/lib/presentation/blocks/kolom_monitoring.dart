import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import '../pages/monitoring/monitoirng_sensor/pengaturan_sensor.dart';
import '../widget/chart/chart_sensor.dart';

class KolomMonitoring extends StatefulWidget {
  final String sensorName;
  final String sensorValue;
  final List<Map<String, dynamic>> sensorData; // Data untuk chart

  const KolomMonitoring({
    super.key,
    required this.sensorName,
    required this.sensorValue,
    required this.sensorData,
  });

  @override
  _KolomMonitoringState createState() => _KolomMonitoringState();
}

class _KolomMonitoringState extends State<KolomMonitoring> {
  bool isPressed = false; // Menyimpan status apakah tombol sedang ditekan

  String formatSensorValue(String value, String sensorName) {
    if (sensorName.toLowerCase().contains('suhu')) {
      return '$value °C';
    } else if (sensorName.toLowerCase().contains('salinitas')) {
      return '$value ppt';
    } else if (sensorName.toLowerCase().contains('kekeruhan')) {
      return '$value NTU';
    } else {
      return value; // pH tetap tanpa satuan
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
          // **Box Background untuk Sensor Name dengan GestureDetector**
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
                      sensorName: widget.sensorName,
                      currentValue: widget.sensorValue,
                      highestValue: '30',
                      lowestValue: '15',
                      initialHighValue: 25,
                      initialLowValue: 20,
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

          // **Sensor Value**
          Positioned(
            right: paddingValue,
            top: screenHeight * 0.01,
            child: Text(
              formatSensorValue(widget.sensorValue, widget.sensorName),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize * 1.2,
                color: ColorConstant.primary,
              ),
            ),
          ),

          // **Garis pemisah**
          Positioned(
            top: screenHeight * 0.05,
            right: paddingValue,
            child: Container(
              width: screenWidth * 0.2,
              height: 1,
              color: const Color(0xFFD9DCD6),
            ),
          ),

          // **Grafik Sensor**
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
