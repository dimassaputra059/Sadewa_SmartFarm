import 'package:flutter/material.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_widget.dart';
import '../../../widget/input/placeholder_input.dart';
import '../../../widget/input/placeholder_role_input.dart';

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
                        const PlaceholderInputWidget(
                          label: "Username",
                          iconPath: "assets/icons/icon-username.png",
                        ),
                        // **Input Email**
                        const PlaceholderInputWidget(
                          label: "Email",
                          iconPath: "assets/icons/icon-email.png",
                        ),
                        // **Dropdown Role**
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

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // **Tombol Simpan**
                SizedBox(
                  width: double.infinity,
                  child: FilledButtonWidget(
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
