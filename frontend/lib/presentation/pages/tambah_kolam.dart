import 'package:flutter/material.dart';
import '../widget/background_widget.dart';
import '../widget/app_bar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/standart_input.dart';

class TambahKolam extends StatelessWidget {
  const TambahKolam({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Untuk responsivitas

    return Scaffold(
      appBar: AppBarWidget(
        title: "Tambah Kolam",
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      resizeToAvoidBottomInset: true, // Memastikan tampilan bisa naik saat keyboard muncul
      body: Stack(
        children: [
          const BackgroundWidget(), // Menggunakan background

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08), // Padding responsif
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Jarak dari atas

                // **Gunakan Expanded agar input dapat di-scroll jika perlu**
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **Input ID Kolam**
                        const StandartInputWidget(label: "ID Kolam"),

                        // **Input Nama Kolam**
                        const StandartInputWidget(label: "Nama Kolam"),

                        const SizedBox(height: 20), // Jarak antara input dan tombol
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
