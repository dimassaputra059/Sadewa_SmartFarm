import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/widget/profile_menu_widget.dart'; // Import widget baru

class ProfileButtonWidget extends StatelessWidget {
  final String username;
  final String role;

  const ProfileButtonWidget({
    super.key,
    required this.username,
    required this.role,
  });

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
      onTap: () {
        RenderBox box = context.findRenderObject() as RenderBox;
        _showProfileMenu(context, box);
      },
      child: Container(
        width: size.width * 0.45,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF316B94),
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
                    username,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    role,
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
