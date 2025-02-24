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
        TextField(
          readOnly: true, // Agar pengguna hanya bisa memilih dari dropdown
          controller: TextEditingController(text: selectedRole ?? ""), // Menampilkan role yang dipilih
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.white, // Warna teks input
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset("assets/icons/icon-role.png", width: 30, height: 30),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpened = !isDropdownOpened;
                });
              },
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: isDropdownOpened ? 0.5 : 0, // Rotasi ikon segitiga
                child: const Icon(Icons.arrow_drop_up, color: Colors.white, size: 24),
              ),
            ),
            labelText: "Role", // Placeholder label di dalam input
            labelStyle: GoogleFonts.poppins(
              fontStyle: FontStyle.italic, // Placeholder italic
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white, // Warna placeholder putih
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

        if (isDropdownOpened)
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            child: Column(
              children: ["Admin", "User"].map((role) {
                return ListTile(
                  title: Text(
                    role,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedRole = role;
                      isDropdownOpened = false;
                    });
                  },
                );
              }).toList(),
            ),
          ),

        const Gap(20), // Jarak setelah input field
      ],
    );
  }
}
