import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../pages/laporan_kualitas_air.dart';
import 'button/button_detail.dart';

class DataWidget extends StatelessWidget {
  final String date;
  final VoidCallback onDetailPressed;
  final VoidCallback onDownloadPressed;

  const DataWidget({
    super.key,
    required this.date,
    required this.onDetailPressed,
    required this.onDownloadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double textSize = constraints.maxWidth < 350 ? 12 : 14;
        double iconSize = constraints.maxWidth < 350 ? 20.0 : 22.0;

        return SizedBox(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Data Tambak $date',
                  style: GoogleFonts.inter(
                    fontSize: textSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF16425B),
                  ),
                  overflow: TextOverflow.ellipsis, // Agar teks tidak kepanjangan di layar kecil
                ),
              ),
              Row(
                children: [
                  ButtonDetailWidget(
                    text: 'Lihat Detail',
                    onPressed: () {
                      // **Navigasi ke halaman LaporanKualitasAir**
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanKualitasAir(date: date),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: onDownloadPressed,
                    icon: Icon(LucideIcons.download, color: const Color(0xFF16425B), size: iconSize),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}