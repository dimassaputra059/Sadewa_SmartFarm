import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';

class ButtonSwitch extends StatefulWidget {
  const ButtonSwitch({super.key});

  @override
  _ButtonSwitchState createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 25, // Atur tinggi switch agar tidak melebihi 25
          child: Transform.scale(
            scale: 0.75, // Sesuaikan skala untuk menyesuaikan tinggi
            child: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeColor: ColorConstant.primary, // Warna biru saat ON
              inactiveTrackColor: Colors.white, // Warna default saat OFF
            ),
          ),
        ),

        Text(
          "Status: ${isSwitched ? "On " : "Off"}",
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic, // Mengubah teks menjadi miring (italic)
            color: ColorConstant.primary,
          ),
        ),
      ],
    );
  }
}
