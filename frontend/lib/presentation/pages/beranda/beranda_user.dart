import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/blocks/tile_kolam.dart';
import 'package:frontend_app/presentation/pages/manajemen/kolam/tambah_kolam.dart';
import '../../blocks/main_header.dart';
import '../../widget/button/button_add.dart';
import '../../widget/background_widget.dart';
import '../manajemen/kolam/edit_kolam.dart';

class BerandaUser extends StatefulWidget {
  const BerandaUser({super.key});

  @override
  State<BerandaUser> createState() => _BerandaUserState();
}

class _BerandaUserState extends State<BerandaUser> {
  List<Map<String, String>> pondList = [
    {"name": "Kolam 1", "status": "Aktif", "date": "06 Februari 2025"},
    {"name": "Kolam 2", "status": "Aktif", "date": "10 Februari 2025"},
    {"name": "Kolam 3", "status": "Tidak Aktif", "date": "15 Februari 2025"},
    {"name": "Kolam 4", "status": "Aktif", "date": "20 Februari 2025"},
  ];

  void _onEditPond(BuildContext context, Map<String, String> pond) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditKolam(
          pondName: pond["name"]!,
          status: pond["status"]!,
        ),
      ),
    );
  }

  void _onDeletePond(String pondName) {
    print("Hapus $pondName");
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),

          // **Header**
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.05,
            child: const MainHeader(),
          ),

          // **Konten Utama**
          Positioned(
            top: screenHeight * 0.20,
            left: screenWidth * 0.06,
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // **Title "Daftar Kolam" dan Button Tambah Kolam (Sejajar)**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Daftar Kolam",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // **GridView untuk PondTile (Responsif)**
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = screenWidth < 600 ? 2 : 3;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: screenWidth * 0.02,
                          mainAxisSpacing: screenHeight * 0.02,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: pondList.length,
                        itemBuilder: (context, index) {
                          var pond = pondList[index];
                          return TileKolam(
                            pondName: pond["name"]!,
                            status: pond["status"]!,
                            date: pond["date"]!,
                            pondData: pond,
                            showMenu: false, // Tidak menampilkan menu titik tiga
                            onEdit: (selectedPond) => _onEditPond(context, selectedPond),
                            onDelete: () => _onDeletePond(pond["name"]!),
                          );
                        },
                      );
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
