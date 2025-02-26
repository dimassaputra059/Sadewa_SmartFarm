import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/profile.dart';
import '../widget/background_widget.dart';
import '../widget/app_bar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/standart_input.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsivitas

    return Scaffold(
      appBar: AppBarWidget(
        title: "Edit Profile",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(), // Menggunakan background

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08), // Padding responsif
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20), // Jarak dari atas

                        // **Input Username**
                        const StandartInputWidget(label: "Username"),

                        // **Input Email**
                        const StandartInputWidget(label: "Email"),
                      ],
                    ),
                  ),
                ),

                // **Tombol Simpan di bawah**
                Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Memberi jarak dari bawah
                  child: SizedBox(
                    width: double.infinity, // Lebar mengikuti halaman
                    child: FilledButtonWidget(
                      text: "Simpan",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Profile()),
                        );
                      },
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
