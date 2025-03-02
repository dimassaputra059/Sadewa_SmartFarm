import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';
import '../widget/button/button_monitoring.dart';
import '../widget/button/toggle_switch.dart';
import '../widget/input/input_value.dart';

class KontrolAerator extends StatelessWidget {
  const KontrolAerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x80D9DCD6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kontrol Aerator",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstant.primary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0x80D9DCD6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "On/Off Aerator",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8), // Beri sedikit jarak antara teks dan switch
                const ToggleSwitchWidget(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Pengaturan waktu interval pengoperasian aerator setelah pemberian pakan.",
            style: TextStyle(
              fontSize: 14, // Perubahan ukuran font menjadi 14
              color: ColorConstant.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0x80D9DCD6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Waktu :",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InputValueWidget(
                        initialValue: 15,
                        minValue: 5,
                        maxValue: 60,
                        step: 5,
                        unit: "Menit",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButtonWidget(
                text: "Simpan",
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}