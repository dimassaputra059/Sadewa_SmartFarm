import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/blocks/pond_tile.dart';
import '../blocks/main_header_widget.dart';
import '../widget/button_add_pond.dart';
import '../widget/navigasi_beranda.dart';
import '../widget/background_widget.dart';
import '../widget/button_widget.dart';
import 'manajemen_user.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<Map<String, String>> pondList = [
    {"name": "Kolam 1", "status": "Aktif", "date": "06 Februari 2025"},
    {"name": "Kolam 2", "status": "Aktif", "date": "10 Februari 2025"},
    {"name": "Kolam 3", "status": "Tidak Aktif", "date": "15 Februari 2025"},
    {"name": "Kolam 4", "status": "Aktif", "date": "20 Februari 2025"},
  ];

  void _onEditPond(String pondName) {
    print("Edit $pondName");
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
            child: const MainHeaderWidget(),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: ButtonAddPond(
                        text: "Tambah Kolam",
                        onPressed: () {
                          print("Tambah Kolam diklik");
                        },
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
                          return PondTile(
                            pondName: pond["name"]!,
                            status: pond["status"]!,
                            date: pond["date"]!,
                            onEdit: () => _onEditPond(pond["name"]!),
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

          // **Navigasi Beranda**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiBeranda(
              selectedIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ManajemenUser()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
