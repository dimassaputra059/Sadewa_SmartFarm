import 'package:flutter/material.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_placeholder.dart';
import '../../../widget/input/input_role_placeholder.dart';

class TambahUser extends StatefulWidget {
  const TambahUser({super.key});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Tambah User",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const BackgroundWidget(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **Input Username**
                        const InputPlaceholder(
                          label: "Username",
                          iconPath: "assets/icons/icon-username.png",
                        ),
                        // **Input Email**
                        const InputPlaceholder(
                          label: "Email",
                          iconPath: "assets/icons/icon-email.png",
                        ),
                        // **Dropdown Role**
                        InputRolePlaceholder(
                          onRoleSelected: (role) {
                            setState(() {
                              selectedRole = role;
                            });
                          },
                        ),

                        // **Input Password**
                        const InputPlaceholder(
                          label: "Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                        ),

                        // **Input Confirm Password**
                        const InputPlaceholder(
                          label: "Confirm Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // **Tombol Simpan**
                SizedBox(
                  width: double.infinity,
                  child: ButtonFilled(
                    text: "Simpan",
                    isFullWidth: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
