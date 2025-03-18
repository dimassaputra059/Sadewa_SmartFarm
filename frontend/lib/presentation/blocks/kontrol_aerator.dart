import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';
import '../../server/api_service.dart';
import '../widget/button/button_outlined.dart';
import '../widget/button/button_switch.dart';
import '../widget/input/input_value.dart';

class KontrolAerator extends StatefulWidget {
  final String pondId;
  const KontrolAerator({super.key, required this.pondId});

  @override
  _KontrolAeratorState createState() => _KontrolAeratorState();
}

class _KontrolAeratorState extends State<KontrolAerator> {
  bool isAeratorOn = false;
  int aeratorDelay = 5; // Default 5 menit
  bool isLoading = true; // Indikator loading

  @override
  void initState() {
    super.initState();
    _fetchAeratorConfig(); // Ambil data dari API saat widget dimuat
  }

  /// 🔄 **Ambil data aerator dari API**
  Future<void> _fetchAeratorConfig() async {
    setState(() => isLoading = true);

    try {
      var statusData = await ApiService.getDeviceConfig(widget.pondId, "aerator/status");
      var delayData = await ApiService.getDeviceConfig(widget.pondId, "aerator/aerator_delay");

      setState(() {
        if (statusData != null && statusData["data"] is bool) {
          isAeratorOn = statusData["data"];
        }
        if (delayData != null && delayData["data"] is num) {
          aeratorDelay = delayData["data"].round(); // Pastikan hasilnya int
        }
      });
    } catch (e) {
      print("❌ Error mengambil data aerator: $e");
    }

    setState(() => isLoading = false);
  }

  /// 🔄 **Update konfigurasi aerator ke API**
  Future<void> _updateAeratorConfig() async {
    setState(() => isLoading = true);

    try {
      bool statusUpdated = await ApiService.updateDeviceConfig(widget.pondId, "aerator/status", {"on": isAeratorOn});
      bool delayUpdated = await ApiService.updateDeviceConfig(widget.pondId, "aerator/aerator_delay", aeratorDelay);

      if (statusUpdated && delayUpdated) {
        print("✅ Aerator berhasil diperbarui!");
      } else {
        print("⚠️ Gagal memperbarui aerator.");
      }
    } catch (e) {
      print("❌ Error saat memperbarui aerator: $e");
    }

    setState(() => isLoading = false);
  }

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

          // **On/Off Aerator**
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0x80D9DCD6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "On/Off Aerator : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                ButtonSwitch(
                  value: isAeratorOn,
                  onChanged: (value) {
                    setState(() {
                      isAeratorOn = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Pengaturan waktu interval pengoperasian aerator setelah pemberian pakan.",
            style: TextStyle(
              fontSize: 14,
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
                      InputValue(
                        initialValue: aeratorDelay.toDouble(), // Konversi int ke double
                        minValue: 5,
                        maxValue: 60,
                        step: 5,
                        unit: "Menit",
                        onChanged: (value) {
                          setState(() {
                            aeratorDelay = value.toInt(); // Konversi double ke int
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // **Tombol Simpan**
              ButtonOutlined(
                text: "Simpan",
                onPressed: isLoading ? () {} : _updateAeratorConfig,
              ),
            ],
          ),
        ],
      ),
    );
  }
}