import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';
import '../widget/button/button_monitoring.dart';
import '../widget/button/toggle_switch.dart';
import '../widget/input/input_schedule.dart';
import '../widget/input/input_value.dart';

class KontrolPakan extends StatelessWidget {
  const KontrolPakan({super.key});

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
            "Kontrol Pakan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstant.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Penjadwalan pemberian pakan udang",
            style: TextStyle(
              fontSize: 14,
              color: ColorConstant.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Row untuk membagi dua kolom (Jadwal Pakan | Status + Jumlah + Simpan)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kolom Jadwal Pakan dengan lebar tetap 200
              SizedBox(
                width: 160, // Lebar tetap 200
                child: Container(
                  padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x80D9DCD6),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      ScheduleTimePicker(label: 'Waktu 1'),
                      ScheduleTimePicker(label: 'Waktu 2'),
                      ScheduleTimePicker(label: 'Waktu 3'),
                      ScheduleTimePicker(label: 'Waktu 4'),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8), // Jarak antar kolom

              // Kolom Status Pakan, Jumlah Pakan, dan Tombol Simpan
              Expanded(
                child: Column(
                  children: [
                    // On/Off Pakan
                    Container(
                      padding: const EdgeInsets.only(top: 4, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0x80D9DCD6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "On/Off Pakan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const ToggleSwitchWidget(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Jumlah Pakan
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 4, right: 10, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0x80D9DCD6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Jumlah Pakan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputValueWidget(
                            initialValue: 100,
                            minValue: 100,
                            maxValue: 500,
                            step: 100,
                            unit: "Gr",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tombol Simpan
                    Center(
                      child: OutlinedButtonWidget(
                        text: "Simpan",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
