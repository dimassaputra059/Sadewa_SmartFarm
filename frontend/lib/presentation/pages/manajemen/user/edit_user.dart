import 'package:flutter/material.dart';
import '../../../../server/api_service.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_standart.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/input/input_role_standart.dart';
import '../../../widget/pop_up/custom_dialog.dart';

class EditUser extends StatefulWidget {
  final String userId;
  final String username;
  final String email;
  final String role;
  final Function onUpdateSuccess; // Callback untuk update tabel

  const EditUser({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
    required this.role,
    required this.onUpdateSuccess,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  String? _selectedRole;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _selectedRole = widget.role;
  }

  Future<void> _saveChanges() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String role = _selectedRole ?? widget.role;

    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username dan email tidak boleh kosong")),
      );
      return;
    }

    if (!email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email harus mengandung '@'")),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await ApiService.editUser(widget.userId, username, email, role);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (success) {
      CustomDialog.show(
        context: context,
        isSuccess: true,
        message: "Data pengguna berhasil diperbarui!",
        onComplete: () {
          widget.onUpdateSuccess(); // Refresh data tabel
          Navigator.pop(context);
        },
      );
    } else {
      CustomDialog.show(
        context: context,
        isSuccess: false,
        message: "Gagal memperbarui data pengguna. Coba lagi.",
      );
    }
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundWidget(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputStandart(
                          label: "Username",
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 12),
                        InputStandart(
                          label: "Email",
                          controller: _emailController,
                        ),
                        const SizedBox(height: 12),
                        InputRoleStandart(
                          selectedRole: _selectedRole,
                          onRoleChanged: (role) {
                            setState(() {
                              _selectedRole = role;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ButtonFilled(
                      text: "Simpan",
                      onPressed: _isLoading ? () {} : _saveChanges,
                    ),
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
