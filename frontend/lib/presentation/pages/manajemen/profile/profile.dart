import 'package:flutter/material.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../blocks/info_profile.dart';
import '../../../widget/button/button_filled.dart';
import 'edit_profile.dart';
import '../../autentikasi/login.dart'; // Import FilledButtonWidget

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
          const BackgroundWidget(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // **Judul Info Pengguna**
                Text(
                  "Info Pengguna",
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // **Daftar Info User**
                InfoProfile(label: "Username", info: "OwnerTambak"),
                const SizedBox(height: 12),
                InfoProfile(label: "Email", info: "OwnerTambak@gmail.com"),
                const SizedBox(height: 12),
                InfoProfile(label: "Role", info: "Admin"),
                const SizedBox(height: 12),
                InfoProfile(label: "Tanggal Daftar", info: "06/02/2025"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
