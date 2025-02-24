import 'package:flutter/material.dart';
import '../widget/background_widget.dart';
import '../widget/app_bar_widget.dart';
import '../widget/info_user_widget.dart';
import '../widget/button_widget.dart';
import 'edit_profile.dart';
import 'login.dart'; // Import FilledButtonWidget

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsivitas

    return Scaffold(
      appBar: AppBarWidget(
        title: "Profile",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(), // Menggunakan background

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // **Judul Info Pengguna**
                Text(
                  "Info Pengguna",
                  style: TextStyle(
                    fontSize: size.width * 0.06, // Ukuran responsif (~18px)
                    fontWeight: FontWeight.w600, // Semibold
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16), // Jarak ke daftar info user

                // **Daftar Info User**
                InfoUserWidget(label: "Username", info: "OwnerTambak"),
                const SizedBox(height: 12),
                InfoUserWidget(label: "Email", info: "OwnerTambak@gmail.com"),
                const SizedBox(height: 12),
                InfoUserWidget(label: "Role", info: "Admin"),
                const SizedBox(height: 12),
                InfoUserWidget(label: "Tanggal Daftar", info: "06/02/2025"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
