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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          "Role",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white, // Warna teks label
          ),
        ),
        const Gap(8), // Jarak antara label dan input

        // Dropdown Input
        DropdownButtonFormField<String>(
          value: selectedRole,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent, // Background transparan
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white), // Warna border default
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF3A7CA5)), // Warna border saat fokus
            ),
          ),
          dropdownColor: Colors.black, // Warna dropdown
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: isDropdownOpened ? 0.5 : 0, // Rotasi ikon segitiga
            child: const Icon(Icons.arrow_drop_up, color: Colors.white, size: 24),
          ),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white, // Warna teks input
          ),
          items: ["Admin", "User"].map((role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role, style: const TextStyle(color: Colors.white)), // Warna teks opsi
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedRole = newValue;
            });
          },
          onTap: () {
            setState(() {
              isDropdownOpened = !isDropdownOpened;
            });
          },
        ),

        const Gap(20), // Jarak setelah input
      ],
    );
  }
}
