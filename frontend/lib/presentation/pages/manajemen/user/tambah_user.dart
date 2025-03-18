import 'package:flutter/material.dart';
import '../../../../server/api_service.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_placeholder.dart';
import '../../../widget/input/input_role_placeholder.dart';
import '../../../widget/pop_up/custom_dialog.dart';

class TambahUser extends StatefulWidget {
  final VoidCallback onUserAdded; // ✅ Callback untuk update tabel otomatis

  const TambahUser({super.key, required this.onUserAdded});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? selectedRole;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _simpanUser() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        selectedRole == null) {
      CustomDialog.show(
        context: context,
        isSuccess: false,
        message: "Semua field harus diisi",
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      CustomDialog.show(
        context: context,
        isSuccess: false,
        message: "Password tidak cocok",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success = await ApiService.addUser(
      usernameController.text,
      emailController.text,
      passwordController.text,
      selectedRole!,
    );

    setState(() {
      isLoading = false;
    });

    CustomDialog.show(
      context: context,
      isSuccess: success,
      message: success ? "User berhasil ditambahkan" : "Gagal menambahkan user",
      onComplete: () {
        if (success) {
          widget.onUserAdded(); // ✅ Panggil callback agar tabel di-update otomatis
          Navigator.pop(context); // ✅ Kembali ke halaman manajemen user
        }
      },
    );
  }

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
      resizeToAvoidBottomInset: false,
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
                        InputPlaceholder(
                          label: "Username",
                          iconPath: "assets/icons/icon-username.png",
                          controller: usernameController,
                        ),
                        InputPlaceholder(
                          label: "Email",
                          iconPath: "assets/icons/icon-email.png",
                          controller: emailController,
                        ),
                        InputRolePlaceholder(
                          onRoleSelected: (role) {
                            setState(() {
                              selectedRole = role;
                            });
                          },
                        ),
                        InputPlaceholder(
                          label: "Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                          controller: passwordController,
                        ),
                        InputPlaceholder(
                          label: "Confirm Password",
                          isPassword: true,
                          iconPath: "assets/icons/icon-password.png",
                          controller: confirmPasswordController,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonFilled(
                    text: "Simpan",
                    onPressed: isLoading ? () {} : _simpanUser,
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
