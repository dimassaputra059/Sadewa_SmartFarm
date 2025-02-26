import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleInputWidget extends StatefulWidget {
  const RoleInputWidget({super.key});

  @override
  _RoleInputWidgetState createState() => _RoleInputWidgetState();
}

class _RoleInputWidgetState extends State<RoleInputWidget> {
  String? selectedRole;
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          "Role",
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.white, // Warna teks label
          ),
        ),
        const Gap(8), // Jarak antara label dan input

        // Input field dengan tinggi responsif
        SizedBox(
          height: size.height * 0.05 < 40 ? 40 : size.height * 0.05, // Tinggi minimal 40px
          child: TextField(
            readOnly: true,
            controller: TextEditingController(text: selectedRole ?? ""),
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.04,
              color: Colors.white,
            ),
            textAlignVertical: TextAlignVertical.center, // **Teks di tengah vertikal**
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isDropdownOpened = !isDropdownOpened;
                  });
                },
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isDropdownOpened ? 0.5 : 0,
                  child: const Icon(Icons.arrow_drop_up, color: Colors.white, size: 24),
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.transparent,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            cursorColor: Colors.white,
            onTap: () {
              setState(() {
                isDropdownOpened = !isDropdownOpened;
              });
            },
          ),
        ),

        // Daftar opsi yang muncul saat dropdown terbuka
        if (isDropdownOpened)
          Container(
            width: size.width * 0.9, // Sesuaikan dengan lebar layar
            margin: EdgeInsets.only(top: size.height * 0.008),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ["Admin", "User"].map((role) {
                bool isSelected = selectedRole == role;
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFD9DCD6) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Mengurangi padding
                    visualDensity: VisualDensity.compact, // Mengurangi tinggi ListTile
                    title: Text(
                      role,
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.04, // Sedikit lebih kecil agar lebih rapi
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedRole = role;
                        isDropdownOpened = false;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

        Gap(size.height * 0.02), // Jarak responsif setelah input field
      ],
    );
  }
}
