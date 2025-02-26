import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/widget/profile_menu_widget.dart'; // Import widget baru

class ProfileButtonWidget extends StatefulWidget {
  final String username;
  final String role;

  const ProfileButtonWidget({
    super.key,
    required this.username,
    required this.role,
  });

  @override
  _ProfileButtonWidgetState createState() => _ProfileButtonWidgetState();
}

class _ProfileButtonWidgetState extends State<ProfileButtonWidget> {
  bool isPressed = false; // State untuk mendeteksi apakah tombol ditekan

  void _showProfileMenu(BuildContext context, RenderBox buttonBox) {
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final buttonWidth = buttonBox.size.width;

    showDialog(
      context: context,
      builder: (context) => ProfileMenuWidget(
        leftPosition: buttonPosition.dx,
        topPosition: buttonPosition.dy + buttonBox.size.height + 5,
        buttonWidth: buttonWidth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true; // Ubah warna background menjadi 0xFF316B94 saat ditekan
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false; // Kembalikan ke transparan setelah dilepas
        });

        RenderBox box = context.findRenderObject() as RenderBox;
        _showProfileMenu(context, box);
      },
      onTapCancel: () {
        setState(() {
          isPressed = false; // Jika interaksi batal, kembalikan ke transparan
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animasi smooth
        width: size.width * 0.45,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isPressed ? const Color(0xFF316B94) : Colors.transparent, // Warna berubah saat ditekan
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/Logo-App.png',
                width: size.width * 0.1,
                height: size.width * 0.1,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 5),

            // **Username & Role**
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.role,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
