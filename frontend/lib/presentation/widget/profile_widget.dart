import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final String username;
  final VoidCallback onTap;

  const ProfileButtonWidget({
    super.key,
    required this.username,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Mengambil ukuran layar

    return GestureDetector(
      onTap: onTap, // Navigasi ke halaman profil
      child: Container(
        width: size.width * 0.4, // Lebar 45% layar
        padding: const EdgeInsets.symmetric(
          horizontal: 8, // Padding kiri-kanan tetap 10
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF316B94), // Warna background biru
          borderRadius: BorderRadius.circular(15), // Border melengkung
          border: Border.all(color: Colors.white, width: 1), // Outline putih
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // **Gambar Profil**
            ClipOval(
              child: Image.asset(
                'assets/images/Logo-App.png', // Ganti dengan logo profil
                width: size.width * 0.1, // Lebar gambar responsif (~9% layar)
                height: size.width * 0.1, // Tinggi gambar responsif
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 5), // Jarak antara gambar dan teks

            // **Username**
            Expanded(
              child: Text(
                username,
                style: const TextStyle(
                  fontSize: 13, // Ukuran teks username tetap 12
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis, // Jika terlalu panjang, jadi "..."
              ),
            ),
          ],
        ),
      ),
    );
  }
}
