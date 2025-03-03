import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputScheduleTime extends StatefulWidget {
  final String label;

  const InputScheduleTime({
    super.key,
    required this.label,
  });

  @override
  _InputScheduleTimeState createState() => _InputScheduleTimeState();
}

class _InputScheduleTimeState extends State<InputScheduleTime> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 7, minute: 0);

  // Fungsi untuk menampilkan Time Picker
  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            timePickerTheme: const TimePickerThemeData(
              dialHandColor: Colors.blue,
              hourMinuteColor: Colors.white,
              hourMinuteTextColor: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Membuat elemen tetap rapat
        children: [
          // Label yang dapat dikonfigurasi
          Text(
            "${widget.label} :",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Warna teks putih
            ),
          ),
          const SizedBox(width: 8), // Jarak kecil antara label dan waktu

          // Waktu yang dapat diklik & Ikon jam
          GestureDetector(
            onTap: () => _pickTime(context),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Membuat teks dan ikon tetap berdekatan
              children: [
                Text(
                  _selectedTime.format(context), // Format waktu (07:00)
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF003A5D), // Warna biru tua
                  ),
                ),
                const SizedBox(width: 0), // Jarak lebih kecil antara waktu dan ikon

                // Ikon jam
                IconButton(
                  icon: const Icon(Icons.access_time, color: Colors.white, size: 18),
                  onPressed: () => _pickTime(context), // Klik ikon untuk memilih waktu
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
