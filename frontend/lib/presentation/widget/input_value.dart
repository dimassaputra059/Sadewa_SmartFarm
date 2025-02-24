import 'package:flutter/material.dart';

import '../../color/color_constant.dart';

class TemperatureInputWidget extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;

  const TemperatureInputWidget({
    super.key,
    this.initialValue = 32,
    this.minValue = 0,
    this.maxValue = 100,
  });

  @override
  _TemperatureInputWidgetState createState() => _TemperatureInputWidgetState();
}

class _TemperatureInputWidgetState extends State<TemperatureInputWidget> {
  late int _temperature;

  @override
  void initState() {
    super.initState();
    _temperature = widget.initialValue;
  }

  void _decreaseTemperature() {
    if (_temperature > widget.minValue) {
      setState(() {
        _temperature--;
      });
    }
  }

  void _increaseTemperature() {
    if (_temperature < widget.maxValue) {
      setState(() {
        _temperature++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol panah kiri (kurangi suhu)
        IconButton(
          icon: const Icon(Icons.arrow_left, color: Colors.black),
          onPressed: _decreaseTemperature,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),

        // Tampilan suhu
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "$_temperature°C",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstant.primary, // Warna teks sesuai contoh
            ),
          ),
        ),

        // Tombol panah kanan (tambah suhu)
        IconButton(
          icon: const Icon(Icons.arrow_right, color: Colors.black),
          onPressed: _increaseTemperature,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
      ],
    );
  }
}
