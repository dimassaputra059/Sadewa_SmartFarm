import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color/color_constant.dart';

class SearchDateWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const SearchDateWidget({super.key, this.onDateSelected});

  @override
  State<SearchDateWidget> createState() => _SearchDateWidgetState();
}

class _SearchDateWidgetState extends State<SearchDateWidget> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true, // Agar user tidak bisa mengetik manual
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: "dd/mm/yyyy",
        hintStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white, // Background putih
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white), // Border putih
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF3A7CA5)), // Warna border saat fokus
        ),
        suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: ColorConstant.primary),
          onPressed: () => _selectDate(context),
        ),
      ),
      onTap: () => _selectDate(context), // Buka kalender saat diklik
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });

      if (widget.onDateSelected != null) {
        widget.onDateSelected!(pickedDate);
      }
    }
  }
}
