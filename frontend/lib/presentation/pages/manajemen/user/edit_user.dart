import 'package:flutter/material.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_standart.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/input/input_role_standart.dart';

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
    selectedRole = widget.role;
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
      resizeToAvoidBottomInset: true,
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
                        // **Input Username**
                        InputStandart(label: "Username"),
                        // **Input Email**
                        InputStandart(label: "Email"),
                        // **Input Role**
                        InputRoleStandart(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
