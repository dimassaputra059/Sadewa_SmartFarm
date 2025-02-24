import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/profile.dart';
import '../widget/background_widget.dart';
import '../widget/app_bar_widget.dart';
import '../widget/filled_button_widget.dart';
import '../widget/standart_input.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsivitas

    return Scaffold(
      appBar: AppBarWidget(
        title: "Edit Profil",
        onBackPress: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Profile()),
          );
        },
      ),
      body: Stack(
        children: [
          const BackgroundWidget(), // Menggunakan background

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08), // Padding responsif
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Jarak dari atas

                // **Input Username**
                const StandartInputWidget(label: "Username"),

                // **Input Email**
                const StandartInputWidget(label: "Email"),

                const Spacer(), // Mengisi ruang kosong agar tombol tetap di bawah

                // **Tombol Simpan**
                SizedBox(
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

                const SizedBox(height: 40), // Jarak dari bawah
              ],
            ),
          ),
        ],
      ),
    );
  }
}
