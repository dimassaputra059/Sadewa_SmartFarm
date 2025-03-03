import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartSensor extends StatelessWidget {
  final List<Map<String, dynamic>> sensorData;

  const ChartSensor({super.key, required this.sensorData});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.02), // Responsif padding
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: screenWidth * 0.08, // Responsif ukuran sumbu Y
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.005),
                    child: Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(fontSize: 10 * textScale),
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: screenHeight * 0.02, // Responsif ukuran sumbu X
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < sensorData.length) {
                    return Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.005),
                      child: Text(
                        sensorData[value.toInt()]["time"],
                        style: TextStyle(fontSize: 10 * textScale),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: sensorData.asMap().entries.map((e) {
                return FlSpot(
                  e.key.toDouble(),
                  (e.value["value"] as num).toDouble(),
                );
              }).toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: screenWidth * 0.007, // Responsif lebar garis
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withAlpha(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
