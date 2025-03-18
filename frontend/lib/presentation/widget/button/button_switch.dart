import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';

class ButtonSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ButtonSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  _ButtonSwitchState createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.value; // Gunakan nilai awal dari parent
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 25,
          child: Transform.scale(
            scale: 0.75,
            child: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
                widget.onChanged(value); // Kirim status ke parent
              },
              activeColor: ColorConstant.primary,
              inactiveTrackColor: Colors.white,
            ),
          ),
        ),

        Text(
          "Status: ${isSwitched ? "On" : "Off"}",
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: ColorConstant.primary,
          ),
        ),
      ],
    );
  }
}
