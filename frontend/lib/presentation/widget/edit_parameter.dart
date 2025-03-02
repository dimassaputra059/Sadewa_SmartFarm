import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import 'button/button_monitoring.dart';
import 'input/input_value.dart';
import 'button/text_button_widget.dart';
import '../pages/informasi_sensor.dart';

class EditParameterWidget extends StatelessWidget {
  final String sensorName;
  final String sensorType;
  final String currentValue;
  final String highestValue;
  final String lowestValue;
  final int initialHighValue;
  final int initialLowValue;

  const EditParameterWidget({
    super.key,
    required this.sensorName,
    required this.sensorType,
    required this.currentValue,
    required this.highestValue,
    required this.lowestValue,
    required this.initialHighValue,
    required this.initialLowValue,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String unit = "°C";
    String label = "Suhu";

    switch (sensorType.toLowerCase()) {
      case "ph":
        unit = "pH";
        label = "pH";
        break;
      case "salinitas":
        unit = "ppt";
        label = "Salinitas";
        break;
      case "kekeruhan":
        unit = "NTU";
        label = "Kekeruhan";
        break;
    }

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.58,
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,  // 5% dari lebar layar
        right: screenWidth * 0.05, // 5% dari lebar layar
        bottom: screenHeight * 0.02, // 2% dari tinggi layar
      ),
      decoration: BoxDecoration(
        color: const Color(0x80D9DCD6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Container(
            height: screenHeight * 0.06,
            width: screenWidth * 0.5,
            decoration: BoxDecoration(
              color: const Color(0xFFD9DCD6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              sensorName,
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
                color: ColorConstant.primary,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),

          // Data Sensor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSensorData("$label \nSaat Ini", currentValue, unit, screenWidth),
              _buildSensorData("$label \nTertinggi", highestValue, unit, screenWidth),
              _buildSensorData("$label \nTerendah", lowestValue, unit, screenWidth),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),
          _buildSettingBox("Tertinggi", initialHighValue, screenWidth, screenHeight),
          _buildSettingBox("Terendah", initialLowValue, screenWidth, screenHeight),


          // Tombol Simpan
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButtonWidget(
                text: "Simpan",
                onPressed: () {
                  // Implementasi penyimpanan parameter
                },
                isFullWidth: false,
                borderColor: ColorConstant.primary,
                textColor: ColorConstant.primary,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Garis Pembatas
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
          ),
          TextButtonWidget(
            text: "Informasi Perangkat Sensor >>",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InformasiSensor()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSensorData(String label, String value, String unit, double screenWidth) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "$value $unit",
          style: TextStyle(
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
            color: ColorConstant.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingBox(String label, int initialValue, double screenWidth, double screenHeight) {
    double minValue = 0, maxValue = 100, step = 1;
    String unit = "°C";
    double recommendedValue = 32;
    String labelText = "";

    switch (sensorType.toLowerCase()) {
      case "ph":
        minValue = 0;
        maxValue = 14;
        step = 0.1;
        unit = " pH";
        recommendedValue = label == "Tertinggi" ? 7.5 : 6;
        labelText = label == "Tertinggi" ? "pH Tertinggi" : "pH Terendah";
        break;
      case "salinitas":
        minValue = 0;
        maxValue = 50;
        unit = " ppt";
        recommendedValue = label == "Tertinggi" ? 15 : 5;
        labelText = label == "Tertinggi" ? "Salinitas Tertinggi" : "Salinitas Terendah";
        break;
      case "kekeruhan":
        minValue = 0;
        maxValue = 1000;
        unit = " NTU";
        recommendedValue = label == "Tertinggi" ? 20 : 10;
        labelText = label == "Tertinggi" ? "Kekeruhan Tertinggi" : "Kekeruhan Terendah";
        break;
      default:
        recommendedValue = label == "Tertinggi" ? 32 : 26;
        labelText = label == "Tertinggi" ? "Suhu Tertinggi" : "Suhu Terendah";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Atur Batasan $labelText\nRekomendasi nilai: ${recommendedValue % 1 == 0 ? recommendedValue.toInt() : recommendedValue}$unit",
                style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.white),
              ),
            ),
            InputValueWidget(
              initialValue: initialValue.toDouble(),
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              unit: unit,
              onChanged: (value) {
                print("$label: $value $unit");
              },
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}
