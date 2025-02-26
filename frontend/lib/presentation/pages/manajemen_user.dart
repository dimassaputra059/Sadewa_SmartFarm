import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/tambah_user.dart';
import '../widget/background_widget.dart';
import '../widget/button_add.dart';
import '../widget/navigasi_beranda.dart';
import '../blocks/main_header_widget.dart';
import '../widget/tabel_user.dart';
import 'beranda.dart';
import 'edit_user.dart';

class ManajemenUser extends StatelessWidget {
  const ManajemenUser({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // **Contoh Data Dummy**
    final List<Map<String, String>> users = [
      {
        'username': 'OwnerTambak',
        'email': 'OwnerTambak@gmail.com',
        'role': 'Admin',
        'createdAt': '06/02/2025',
      },
      {
        'username': 'UserTambak',
        'email': 'UserTambak@gmail.com',
        'role': 'User',
        'createdAt': '06/02/2025',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(), // Latar belakang

          // **Header Baru (Jam, Tanggal, Profile, Underline)**
          const Positioned(
            left: 0,
            right: 0,
            top: 35,
            child: MainHeaderWidget(),
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
                // **Title "Manajemen User" dan Button Tambah User (Sejajar)**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Manajemen User",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ButtonAdd(
                        text: "Tambah User",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TambahUser(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Spacer

                // **Tabel User dengan Scroll Horizontal**
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 100, // Tinggi minimal agar tetap terlihat jika data sedikit
                      maxHeight: (40.0 + users.length * 48).clamp(100, MediaQuery.of(context).size.height * 0.7),
                      // Header height (40) + setiap baris 48px, dengan batas maksimal 70% dari tinggi layar
                    ),
                    child: UserManagementTable(users: users),
                  ),
                ),


              ],
            ),
          ),

          // **Navigasi Beranda dalam Stack**
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigasiBeranda(
              selectedIndex: 1,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Beranda()),
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
