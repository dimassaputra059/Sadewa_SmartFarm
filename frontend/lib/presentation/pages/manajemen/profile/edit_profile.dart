import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/manajemen/profile/profile.dart';
import '../../../../server/api_service.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_standart.dart';
import '../../../widget/pop_up/custom_dialog.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final userData = await ApiService.getProfile();
    if (userData != null) {
      setState(() {
        _usernameController.text = userData["username"] ?? "";
        _emailController.text = userData["email"] ?? "";
      });
    }
  }

  Future<void> _editProfile() async {
    debugPrint("Username: '${_usernameController.text}'");
    debugPrint("Email: '${_emailController.text}'");

    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();

    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username dan email tidak boleh kosong")),
      );
      return;
    }

    // **Validasi email harus mengandung '@'**
    if (!email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email harus mengandung '@'")),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await ApiService.editProfile(username, email);

    if (!mounted) return; // Cegah error jika widget sudah tidak aktif

    setState(() => _isLoading = false);

    if (success) {
      CustomDialog.show(
        context: context,
        isSuccess: true,
        message: "Profil berhasil diperbarui!",
        onComplete: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Profile()),
          );
        },
      );
    } else {
      CustomDialog.show(
        context: context,
        isSuccess: false,
        message: "Gagal memperbarui profil. Coba lagi.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Edit Profile",
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
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        InputStandart(label: "Username", controller: _usernameController),
                        const SizedBox(height: 12),
                        InputStandart(label: "Email", controller: _emailController),
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
                      onPressed: _isLoading ? () {} : _editProfile,
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
