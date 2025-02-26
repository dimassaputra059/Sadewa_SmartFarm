import 'package:flutter/material.dart';
import '../widget/background_widget.dart';
import '../widget/app_bar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/placeholder_input.dart';
import '../widget/placeholder_role_input.dart';

class TambahUser extends StatefulWidget {
  const TambahUser({super.key});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  String? selectedRole; // Menyimpan pilihan role (Admin/User)

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsivitas

    return Scaffold(
      appBar: AppBarWidget(
        title: "Tambah User",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      resizeToAvoidBottomInset: true, // **Agar layar naik saat keyboard muncul**
      body: Stack(
        children: [
          const BackgroundWidget(), // Menggunakan background

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08), // Padding responsif
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Jarak dari atas

                // **Gunakan Expanded + SingleChildScrollView agar input bisa di-scroll**
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **Input Username**
                        const PlaceholderInputWidget(
                          label: "Username",
                          iconPath: "assets/icons/icon-username.png",
                        ),

                        // **Input Email**
                        const PlaceholderInputWidget(
                          label: "Email",
                          iconPath: "assets/icons/icon-email.png",
                        ),

                        // **Dropdown Role (Menggunakan PlaceholderRoleInput)**
                        PlaceholderRoleInput(
                          onRoleSelected: (role) {
                            setState(() {
                              selectedRole = role;
                            });
                          },
                        ),

                        // **Input Password**
                        const PlaceholderInputWidget(
                          label: "Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                        ),

                        // **Input Confirm Password**
                        const PlaceholderInputWidget(
                          label: "Confirm Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                        ),

                        const SizedBox(height: 20), // Jarak bawah agar tidak menempel dengan tombol
                      ],
                    ),
                  ),
                ),
                // **Tombol Simpan**
                SizedBox(
                  width: double.infinity, // Agar tombol selebar layar
                  child: FilledButtonWidget(
                    text: "Simpan",
                    isFullWidth: true,
                    onPressed: () {
                      // Aksi setelah menyimpan kolam
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 20), // Jarak bawah agar tidak menempel dengan layar
              ],
            ),
          ),
        ],
      ),
    );
  }
}
