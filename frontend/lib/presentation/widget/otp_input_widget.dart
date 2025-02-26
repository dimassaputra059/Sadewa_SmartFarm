import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPInputWidget extends StatefulWidget {
  final Function(String)? onComplete; // Callback saat OTP selesai diinput

  const OTPInputWidget({super.key, this.onComplete});

  @override
  State<OTPInputWidget> createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  final Color borderColor = const Color(0xFF81C3D7); // Warna border tetap

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]); // Pindah ke input berikutnya
      } else {
        FocusScope.of(context).unfocus(); // Tutup keyboard jika sudah 4 digit
        _submitOTP();
      }
    }
  }

  void _submitOTP() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      widget.onComplete?.call(otp); // Panggil callback onComplete
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(

          width: 40, // Lebar kotak input
          height: 40, // Tinggi kotak input
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.black,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black, // Warna teks input
            ),
            maxLength: 1, // Hanya bisa 1 karakter per kotak
            decoration: InputDecoration(
              counterText: "", // Sembunyikan hitungan karakter
              filled: true, // Aktifkan warna background
              fillColor: Colors.white, // Background putih
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white), // Warna border default
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor, width: 2), // Warna border saat fokus
              ),
            ),
            onChanged: (value) => _onChanged(index, value),
          ),
        );
      }),
    );
  }
}
