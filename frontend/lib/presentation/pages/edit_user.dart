import 'package:flutter/material.dart';
import '../widget/app_bar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/standart_input.dart';
import '../widget/background_widget.dart';
import '../widget/standart_role_input.dart';

class EditUser extends StatefulWidget {
  final String username;
  final String email;
  final String role;

  const EditUser({
    super.key,
    required this.username,
    required this.email,
    required this.role,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role; // Menetapkan role awal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Edit ${widget.username}",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      resizeToAvoidBottomInset: true, // Agar layar menyesuaikan saat keyboard muncul
      body: Stack(
        children: [
          const BackgroundWidget(), // **Latar belakang**

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                // **Expanded dengan SingleChildScrollView agar bisa scroll**
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **Input Username**
                        StandartInputWidget(label: "Username"),

                        // **Input Email**
                        StandartInputWidget(label: "Email"),

                        // **Input Role**
                        RoleInputWidget(),
                      ],
                    ),
                  ),
                ),

                // **Tombol Simpan Tetap di Bawah**
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
