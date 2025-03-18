import 'package:flutter/material.dart';
import '../../../../server/api_service.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_filled.dart';
import '../../../widget/input/input_standart.dart';
import '../../../widget/pop_up/custom_dialog.dart';

class TambahKolam extends StatefulWidget {
  final VoidCallback onKolamAdded; //

  const TambahKolam({super.key, required this.onKolamAdded});

  @override
  State<TambahKolam> createState() => _TambahKolamState();
}

class _TambahKolamState extends State<TambahKolam> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false; // ✅ Untuk menampilkan loading saat submit

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _simpanKolam() async {
    String idPond = _idController.text.trim();
    String namePond = _nameController.text.trim();

    if (idPond.isEmpty || namePond.isEmpty) {
      CustomDialog.show(
        context: context,
        isSuccess: false,
        message: "ID dan Nama Kolam tidak boleh kosong!",
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await ApiService.addKolam(idPond, namePond);

    setState(() {
      _isLoading = false;
    });

    CustomDialog.show(
      context: context,
      isSuccess: success,
      message: success ? "Kolam berhasil ditambahkan" : "Gagal menambahkan kolam. Coba lagi!",
      onComplete: () {
        if (success) {
          widget.onKolamAdded(); // ✅ Panggil callback agar data di halaman sebelumnya diperbarui
          Navigator.pop(context); // ✅ Tutup halaman setelah sukses
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Tambah Kolam",
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
                        InputStandart(label: "ID Kolam", controller: _idController),
                        InputStandart(label: "Nama Kolam", controller: _nameController),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonFilled(
                    text: "Simpan",
                    onPressed: _isLoading ? () {} : _simpanKolam,
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
