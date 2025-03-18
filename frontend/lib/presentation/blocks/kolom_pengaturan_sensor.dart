import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import '../../server/api_service.dart';
import '../widget/button/button_outlined.dart';
import '../widget/input/input_value.dart';
import '../widget/button/button_text.dart';
import '../pages/monitoring/monitoirng_sensor/informasi_sensor.dart';

class KolomPengaturanSensor extends StatefulWidget {
  final String pondId;
  final String sensorName;
  final String namePond;
  final String sensorType;

  const KolomPengaturanSensor({
    super.key,
    required this.pondId,
    required this.sensorName,
    required this.sensorType, required this.namePond,
  });

  @override
  _KolomPengaturanSensorState createState() => _KolomPengaturanSensorState();
}

class _KolomPengaturanSensorState extends State<KolomPengaturanSensor> {
  double? highestValue;
  double? lowestValue;
  double? tempHighValue;
  double? tempLowValue;
  double? currentSensorValue;

  late double recommendedHighValue;
  late double recommendedLowValue;

  @override
  void initState() {
    super.initState();
    setRecommendedValues();
    fetchSensorConfig();
  }

  void setRecommendedValues() {
    switch (widget.sensorType.toLowerCase()) {
      case "ph":
        recommendedHighValue = 9;
        recommendedLowValue = 7;
        break;
      case "salinity":
        recommendedHighValue = 35;
        recommendedLowValue = 15;
        break;
      case "turbidity":
        recommendedHighValue = 40;
        recommendedLowValue = 0;
        break;
      case "temperature":
      default:
        recommendedHighValue = 32;
        recommendedLowValue = 26;
        break;
    }
  }

  Future<void> fetchSensorConfig() async {
    String basePath = "thresholds/${widget.sensorType.toLowerCase()}";
    String sensorType = widget.sensorType.toLowerCase();

    Map<String, dynamic>? highestData = await ApiService.getDeviceConfig(widget.pondId, "$basePath/high");
    Map<String, dynamic>? lowestData = await ApiService.getDeviceConfig(widget.pondId, "$basePath/low");
    Map<String, dynamic>? sensorValueData = await ApiService.getMonitoringData(widget.pondId, sensorType);

    setState(() {
      highestValue = highestData?["data"]?.toDouble();
      lowestValue = lowestData?["data"]?.toDouble();
      tempHighValue = highestValue ?? recommendedHighValue;
      tempLowValue = lowestValue ?? recommendedLowValue;
      currentSensorValue = sensorValueData?["sensor_data"]?.toDouble();
    });
  }

  Future<void> saveThresholdValues() async {
    if (tempHighValue != null && tempLowValue != null) {
      String basePath = "thresholds/${widget.sensorType.toLowerCase()}";
      await ApiService.updateDeviceConfig(widget.pondId, "$basePath/high", tempHighValue);
      await ApiService.updateDeviceConfig(widget.pondId, "$basePath/low", tempLowValue);

      setState(() {
        highestValue = tempHighValue;
        lowestValue = tempLowValue;
      });
    }
  }

  String formatNumber(double? number) {
    if (number == null) return "--";
    return number % 1 == 0 ? number.toInt().toString() : number.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String unit = "°C";
    String label = "Suhu";
    double minValue = -50, maxValue = 100, step = 1;

    switch (widget.sensorType.toLowerCase()) {
      case "ph":
        unit = "pH";
        label = "pH";
        minValue = 0;
        maxValue = 14;
        step = 0.01;
        break;
      case "salinity":
        unit = "ppt";
        label = "Salinitas";
        minValue = 0;
        maxValue = 100;
        step = 1;
        break;
      case "turbidity":
        unit = "NTU";
        label = "Kekeruhan";
        minValue = 0;
        maxValue = 1000;
        step = 1;
        break;
    }

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.7,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: const Color(0x80D9DCD6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          _buildHeader(screenWidth),
          SizedBox(height: screenHeight * 0.03),

          // Data Sensor
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSensorData("$label \nSaat Ini", formatNumber(currentSensorValue), unit, screenWidth),
              _buildSensorData("$label \nTertinggi", formatNumber(highestValue), unit, screenWidth),
              _buildSensorData("$label \nTerendah", formatNumber(lowestValue), unit, screenWidth),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),

          if (tempHighValue != null && tempLowValue != null) ...[
            _buildSettingBox("Tertinggi", tempHighValue!, minValue, maxValue, unit, recommendedHighValue, screenWidth, screenHeight, (value) {
              setState(() {
                tempHighValue = value;
              });
            }),
            SizedBox(height: screenHeight * 0.01),
            _buildSettingBox("Terendah", tempLowValue!, minValue, maxValue, unit, recommendedLowValue, screenWidth, screenHeight, (value) {
              setState(() {
                tempLowValue = value;
              });
            }),
          ] else
            CircularProgressIndicator(),

          SizedBox(height: screenHeight * 0.02),
          _buildSaveButton(),

          SizedBox(height: screenHeight * 0.015),
          _buildInfoButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Container(
      height: 50,
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
        widget.sensorName,
        style: TextStyle(
          fontSize: screenWidth * 0.055,
          fontWeight: FontWeight.bold,
          color: ColorConstant.primary,
        ),
      ),
    );
  }

  Widget _buildSensorData(String label, String value, String unit, double screenWidth) {
    return Column(
      children: [
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white)),
        Text("$value $unit", style: TextStyle(fontSize: screenWidth * 0.065, fontWeight: FontWeight.bold, color: ColorConstant.primary)),
      ],
    );
  }

  Widget _buildSettingBox(String label, double value, double minValue, double maxValue, String unit, double recommendedValue, double screenWidth, double screenHeight, Function(double) onChanged) {
    double step = 1.0; // Default step value

    // Menentukan step sesuai tipe sensor
    switch (widget.sensorType.toLowerCase()) {
      case "ph":
        step = 0.1;
        break;
      case "salinity":
        step = 1;
        break;
      case "turbidity":
        step = 1;
        break;
      case "temperature":
        step = 1;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label",
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
                "Atur batasan $label \nNilai rekomendasi: ${value % 1 == 0 ? value.toInt() : value}$unit",
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  color: Colors.white,
                ),
              ),
            ),
            InputValue(
              initialValue: value,
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              unit: unit,
              onChanged: onChanged,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }


  Widget _buildSaveButton() {
    return ButtonOutlined(
      text: "Simpan",
      onPressed: saveThresholdValues,
      isFullWidth: true,
      borderColor: ColorConstant.primary,
      textColor: ColorConstant.primary,
    );
  }

  Widget _buildInfoButton(BuildContext context) {
    return ButtonText(
      text: "Informasi Perangkat Sensor >>",
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => InformasiSensor(sensorType: widget.sensorType, pondId: widget.pondId, namePond: widget.namePond)));
      },
    );
  }
}
