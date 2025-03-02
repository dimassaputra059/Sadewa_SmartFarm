import 'package:flutter/material.dart';

class StatusSwitchWidget extends StatefulWidget {
  const StatusSwitchWidget({super.key});

  @override
  _StatusSwitchWidgetState createState() => _StatusSwitchWidgetState();
}

class _StatusSwitchWidgetState extends State<StatusSwitchWidget> {
  bool isOn = false; // Status awal

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Toggle Switch
        Switch(
          value: isOn,
          onChanged: (value) {
            setState(() {
              isOn = value;
            });
          },
          activeColor: Colors.green, // Warna saat ON
          inactiveThumbColor: Colors.grey, // Warna saat OFF
          inactiveTrackColor: Colors.grey.shade400,
        ),
        const SizedBox(width: 8), // Jarak antara switch dan teks

        // Status Text
        Text(
          "Status: ${isOn ? "On" : "Off"}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Warna teks
          ),
        ),
      ],
    );
  }
}
