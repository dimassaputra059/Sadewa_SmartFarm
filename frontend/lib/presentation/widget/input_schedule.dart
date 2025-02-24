import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleTimePicker extends StatefulWidget {
  const ScheduleTimePicker({super.key});

  @override
  _ScheduleTimePickerState createState() => _ScheduleTimePickerState();
}

class _ScheduleTimePickerState extends State<ScheduleTimePicker> {
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label "Jadwal 1:"
        Text(
          "Jadwal 1:",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white, // Warna teks putih
          ),
        ),
        const SizedBox(width: 8), // Jarak kecil antara label dan waktu

        // Waktu yang dapat diklik
        GestureDetector(
          onTap: () => _pickTime(context),
          child: Text(
            _selectedTime.format(context), // Format waktu (07:00)
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF003A5D), // Warna biru tua
            ),
          ),
        ),
        const SizedBox(width: 8), // Jarak kecil antara waktu dan ikon

        // Ikon jam
        IconButton(
          icon: const Icon(Icons.access_time, color: Colors.white),
          onPressed: () => _pickTime(context), // Klik ikon untuk memilih waktu
        ),
      ],
    );
  }
}
