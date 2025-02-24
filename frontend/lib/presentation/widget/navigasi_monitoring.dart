import 'package:flutter/material.dart';
import '../../color/color_constant.dart';

class NavigasiMonitoring extends StatefulWidget {
  final Function(int) onTap; // Callback untuk berpindah halaman
  final int selectedIndex; // Indeks halaman aktif

  const NavigasiMonitoring({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  _NavigasiMonitoringState createState() => _NavigasiMonitoringState();
}

class _NavigasiMonitoringState extends State<NavigasiMonitoring> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: Container(
        height: 60, // Tinggi navigasi
        decoration: const BoxDecoration(
          color: Colors.transparent, // Pastikan transparan
        ),
        child: Row(
          children: [
            // Tombol Monitoring
            _buildNavItem(
              index: 0,
              iconPath: "assets/icons/icon-monitoring.png",
            ),

            // Tombol History
            _buildNavItem(
              index: 1,
              iconPath: "assets/icons/icon-history.png",
            ),

            // Tombol Notification
            _buildNavItem(
              index: 2,
              iconPath: "assets/icons/icon-notification.png",
            ),

            // Tombol Control
            _buildNavItem(
              index: 3,
              iconPath: "assets/icons/icon-control.png",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String iconPath}) {
    bool isSelected = widget.selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index), // Navigasi saat diklik
        child: Container(
          height: 60, // Tinggi navigasi
          decoration: BoxDecoration(
            color: isSelected
                ? ColorConstant.primary
                : const Color(0xFFD9DCD6).withAlpha(64), // 25% transparan
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 30, // Ukuran ikon tetap 30x30
              height: 30,
              color: Colors.white, // Warna ikon tetap putih
            ),
          ),
        ),
      ),
    );
  }
}
