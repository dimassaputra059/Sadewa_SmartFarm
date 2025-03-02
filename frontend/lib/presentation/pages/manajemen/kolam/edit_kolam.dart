import 'package:flutter/material.dart';
import '../../../widget/navigation/app_bar_widget.dart';
import '../../../widget/button/button_widget.dart';
import '../../../widget/input/standart_input.dart';
import '../../../widget/background_widget.dart';
import '../../../widget/input/standart_status_input.dart';

class EditKolam extends StatefulWidget {
  final String pondName;
  final String status;

  const EditKolam({
    super.key,
    required this.pondName,
    required this.status,
  });

  @override
  State<EditKolam> createState() => _EditKolamState();
}

class _EditKolamState extends State<EditKolam> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.pondName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Edit ${widget.pondName}",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // **Input Nama Kolam**
                        StandartInputWidget(
                          label: "Nama Kolam",
                        ),
                        // **Input Status Kolam Aktif/Non-Aktif**
                        StatusInputWidget(),

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
