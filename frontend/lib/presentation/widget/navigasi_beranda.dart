import 'package:flutter/material.dart';
import '../../color/color_constant.dart';

class NavigasiBeranda extends StatefulWidget {
  final Function(int) onTap; // Callback untuk berpindah halaman
  final int selectedIndex; // Indeks halaman aktif

  const NavigasiBeranda({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  _NavigasiBerandaState createState() => _NavigasiBerandaState();
}

class _NavigasiBerandaState extends State<NavigasiBeranda> {
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
            // Tombol Beranda (30x30)
            _buildNavItem(
              index: 0,
              iconPath: "assets/icons/icon-beranda.png",
              iconSize: 30, // Ukuran ikon beranda
            ),

            // Tombol Manajemen User (36x36)
            _buildNavItem(
              index: 1,
              iconPath: "assets/icons/icon-manajemen-user.png",
              iconSize: 36, // Ukuran ikon manajemen user
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String iconPath, required double iconSize}) {
    bool isSelected = widget.selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index), // Navigasi saat diklik
        child: Container(
          height: 64, // Tinggi navigasi
          decoration: BoxDecoration(
            color: isSelected
                ? ColorConstant.primary
                : const Color(0xFFD9DCD6).withAlpha(64), // 25% transparan
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: iconSize, // Ukuran ikon sesuai dengan parameter
              height: iconSize,
              color: Colors.white, // Warna ikon tetap putih
            ),
          ),
        ),
      ),
    );
  }
}
