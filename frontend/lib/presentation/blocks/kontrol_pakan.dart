import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../color/color_constant.dart';
import '../../server/api_service.dart';
import '../widget/button/button_outlined.dart';
import '../widget/button/button_switch.dart';
import '../widget/input/input_schedule_time.dart';
import '../widget/input/input_value.dart';

class KontrolPakan extends StatefulWidget {
  final String pondId;
  const KontrolPakan({super.key, required this.pondId});

  @override
  _KontrolPakanState createState() => _KontrolPakanState();
}

class _KontrolPakanState extends State<KontrolPakan> {
  List<TimeOfDay?> _feedingSchedule = List.filled(4, null);
  bool isFeedingOn = false;
  double feedAmount = 100.0;
  bool isLoading = true; // Indikator loading awal
  bool isSaving = false; // Indikator tombol Simpan

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  // 🔹 Mengambil data awal dari Firebase saat halaman dibuka
  Future<void> _loadInitialData() async {
    try {
      var scheduleData = await ApiService.getDeviceConfig(widget.pondId, "feeding_schedule/schedule");
      var statusData = await ApiService.getDeviceConfig(widget.pondId, "feeding_schedule/status");
      var amountData = await ApiService.getDeviceConfig(widget.pondId, "feeding_schedule/amount");

      if (scheduleData != null && scheduleData["data"] is List) {
        List<String> scheduleList = List<String>.from(scheduleData["data"]);
        setState(() {
          _feedingSchedule = List.generate(4, (index) {
            if (index < scheduleList.length && scheduleList[index].contains(":")) {
              List<String> parts = scheduleList[index].split(":");
              return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
            }
            return null;
          });
        });
      }

      if (statusData != null && statusData["data"] is bool) {
        setState(() {
          isFeedingOn = statusData["data"];
        });
      }

      if (amountData != null && amountData["data"] is num) {
        setState(() {
          feedAmount = amountData["data"].toDouble();
        });
      }
    } catch (e) {
      print("❌ Error saat mengambil konfigurasi: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔹 Menyimpan data ke Firebase hanya saat tombol "Simpan" ditekan
  Future<void> _saveData() async {
    setState(() {
      isSaving = true;
    });

    try {
      // 🔹 Konversi TimeOfDay ke List<String> untuk schedule
      List<String> formattedSchedule = _feedingSchedule
          .where((time) => time != null) // Hanya waktu yang tidak null
          .map((time) =>
      "${time!.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}")
          .toList();

      // 🔹 Kirim seluruh jadwal sebagai array ke Firebase
      if (formattedSchedule.isNotEmpty) {
        await ApiService.updateDeviceConfig(widget.pondId, "feeding_schedule/schedule", formattedSchedule);
      }

      // 🔹 Kirim jumlah pakan sebagai integer
      await ApiService.updateDeviceConfig(widget.pondId, "feeding_schedule/amount", feedAmount.toInt());

      // 🔹 Kirim status sebagai boolean (pastikan bukan string!)
      await ApiService.updateDeviceConfig(widget.pondId, "feeding_schedule/status", {"on": isFeedingOn});

      print("📤 Sending status: ${isFeedingOn.runtimeType} - $isFeedingOn");

      // ✅ Notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfigurasi berhasil disimpan")),
      );
    } catch (e) {
      print("❌ Error saat menyimpan konfigurasi: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menyimpan data")),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Kolom Jadwal Pakan**
              SizedBox(
                width: 160,
                child: Container(
                  padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color(0x80D9DCD6),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Column(
                    children: List.generate(4, (index) {
                      return InputScheduleTime(
                        label: 'Waktu ${index + 1}',
                        initialTime: _feedingSchedule[index] ?? const TimeOfDay(hour: 7, minute: 0),
                        onTimeSelected: (TimeOfDay? newTime) {
                          setState(() {
                            _feedingSchedule[index] = newTime;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  children: [
                    // **On/Off Pakan**
                    Container(
                      padding: const EdgeInsets.only(top: 4, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0x80D9DCD6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "On/Off Pakan",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          ButtonSwitch(
                            value: isFeedingOn,
                            onChanged: (value) {
                              setState(() {
                                isFeedingOn = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // **Jumlah Pakan**
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0x80D9DCD6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Jumlah Pakan",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                          InputValue(
                            initialValue: feedAmount,
                            minValue: 100,
                            maxValue: 500,
                            step: 100,
                            unit: "Gr",
                            onChanged: (value) {
                              setState(() {
                                feedAmount = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: isSaving
                          ? const CircularProgressIndicator()
                          : ButtonOutlined(
                        text: "Simpan",
                        onPressed: _saveData,
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
