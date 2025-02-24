import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../color/color_constant.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPress;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.onBackPress,
  });

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
            padding: const EdgeInsets.only(left: 10), // Padding kiri 20 untuk ikon back
            child: IconButton(
              icon: Image.asset(
                'assets/icons/icon-back.png', // Path ikon back
                width: size.width * 0.1, // Ukuran responsif (~7% lebar layar)
              ),
              onPressed: onBackPress,
            ),
          ),
          SizedBox(width: size.width * 0.01), // Jarak antara ikon dan title (~3% layar)
          Text(
            title,
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

  @override
  Size get preferredSize => const Size.fromHeight(60); // Ukuran tetap 60
}
