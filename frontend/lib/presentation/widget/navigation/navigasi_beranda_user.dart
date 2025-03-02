import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';

class NavigasiBerandaUser extends StatefulWidget {
  final Function(int) onTap; // Callback untuk berpindah halaman
  final int selectedIndex; // Indeks halaman aktif

  const NavigasiBerandaUser({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  _NavigasiBerandaUserState createState() => _NavigasiBerandaUserState();
}

class _NavigasiBerandaUserState extends State<NavigasiBerandaUser> {
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
        child: Center( // Menengahkan ikon beranda
          child: _buildNavItem(
            index: 0,
            iconPath: "assets/icons/icon-beranda.png",
            iconSize: 30, // Ukuran ikon beranda
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String iconPath, required double iconSize}) {
    bool isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index), // Navigasi saat diklik
      child: Container(
        height: 60, // Tinggi navigasi
        width: 60, // Lebar ikon agar seimbang
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Membuat tombol berbentuk bulat
          color: ColorConstant.primary,
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: iconSize, // Ukuran ikon sesuai parameter
            height: iconSize,
            color: Colors.white, // Warna ikon tetap putih
          ),
        ),
      ),
    );
  }
}
