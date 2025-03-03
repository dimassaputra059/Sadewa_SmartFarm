import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class InputPlaceholder extends StatefulWidget {
  final String label;
  final bool isPassword;
  final String? iconPath;

  const InputPlaceholder({
    super.key,
    required this.label,
    this.isPassword = false,
    this.iconPath,
  });

  @override
  _InputPlaceholderState createState() => _InputPlaceholderState();
}

class _InputPlaceholderState extends State<InputPlaceholder> {
  bool _obscureText = true; // Status awal: Password disembunyikan

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Ambil ukuran layar

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.06 < 50 ? 50 : size.height * 0.06,
          child: TextField(
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, // Tidak italic
              fontSize: size.width * 0.04, // Sekitar 4% dari lebar layar
              color: Colors.white, // Warna teks input menjadi putih
            ),
            obscureText: widget.isPassword ? _obscureText : false, // Password mode
            decoration: InputDecoration(
              prefixIcon: widget.iconPath != null
                  ? Padding(
                padding: EdgeInsets.all(size.width * 0.03), // Padding responsif
                child: Image.asset(widget.iconPath!,
                    width: size.width * 0.06, height: size.width * 0.06), // Ikon responsif
              )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility, // Mata terbuka/tutup
                  color: Colors.white, // Warna ikon putih
                  size: size.width * 0.05, // Ukuran ikon responsif
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle status password
                  });
                },
              )
                  : null,
              labelText: widget.label, // Placeholder text
              labelStyle: GoogleFonts.poppins(
                fontStyle: FontStyle.italic, // Placeholder italic
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04, // Ukuran teks responsif
                color: Colors.white, // Warna placeholder putih
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never, // Placeholder hilang saat mengetik
              fillColor: Colors.transparent, // Background transparan
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.03), // Padding responsif
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.025), // Border melengkung responsif
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.025),
                borderSide: const BorderSide(color: Colors.white), // Warna saat fokus
              ),
            ),
            cursorColor: Colors.white, // Warna kursor putih
          ),
        ),
        const Gap(20), // Jarak setelah input field
      ],
    );
  }
}
