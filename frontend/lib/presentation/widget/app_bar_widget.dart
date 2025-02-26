import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../color/color_constant.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPress;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.onBackPress,
  });

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60); // Ukuran tetap 60
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isPressed = false; // State untuk mendeteksi apakah tombol ditekan

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Mendapatkan ukuran layar untuk responsivitas

    return AppBar(
      backgroundColor: ColorConstant.primary,
      elevation: 0,
      automaticallyImplyLeading: false, // HILANGKAN BACK BUTTON DEFAULT
      centerTitle: false,
      titleSpacing: 0, // Hilangkan jarak default
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20), // Padding kiri untuk ikon back
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  isPressed = true; // Ubah warna ikon menjadi biru saat ditekan
                });
              },
              onTapUp: (_) {
                setState(() {
                  isPressed = false; // Kembalikan ke warna normal setelah dilepas
                });
                widget.onBackPress(); // Eksekusi aksi back setelah dilepas
              },
              onTapCancel: () {
                setState(() {
                  isPressed = false; // Pastikan kembali ke warna normal jika interaksi batal
                });
              },
              child: Image.asset(
                'assets/icons/icon-back.png', // Path ikon back
                width: size.width * 0.12, // Ukuran responsif (~7% lebar layar)
                color: isPressed ? const Color(0xFF316B94) : null, // Ubah warna ikon saat ditekan
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02), // Jarak antara ikon dan title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: size.width * 0.06, // Ukuran teks responsif (~5% lebar layar)
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600, // Semibold
              color: Colors.white,
            ),
          ),
        ],
      ),
      toolbarHeight: 60, // Tinggi AppBar tetap 60
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
