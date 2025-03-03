import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../color/color_constant.dart';

class InputDate extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const InputDate({super.key, this.onDateSelected});

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate; // Menampung tanggal yang dipilih

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double fontSize = width < 300 ? 11.0 : 12.0;
        double iconSize = width < 300 ? 14.0 : 16.0;
        double padding = width < 300 ? 6.0 : 8.0;

        return SizedBox(
          height: 30, // Menetapkan tinggi input
          child: TextField(
            controller: _dateController,
            readOnly: true, // Agar user tidak bisa mengetik manual
            textAlign: TextAlign.center, // Teks berada di tengah horizontal
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: ColorConstant.primary, // Ubah warna teks menjadi primary
            ),
            decoration: InputDecoration(
              hintText: "dd/mm/yyyy",
              hintStyle: GoogleFonts.poppins(
                fontSize: fontSize,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.white, // Background putih
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white), // Border putih
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConstant.primary), // Border saat fokus
              ),
              isDense: true, // Mengurangi padding bawaan
              contentPadding: EdgeInsets.symmetric(vertical: padding), // Pastikan teks sejajar vertikal
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: ColorConstant.primary, size: iconSize), // Perkecil ikon
                onPressed: () => _selectDate(context),
              ),
            ),
            onTap: () => _selectDate(context),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate; // Simpan tanggal yang dipilih
        _dateController.text =
        "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });

      // Panggil callback jika ada untuk memfilter data berdasarkan tanggal
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(pickedDate);
      }
    }
  }
}
