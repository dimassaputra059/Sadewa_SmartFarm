import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../pages/monitoring/riwayat_kualitas_air/laporan_kualitas_air.dart';
import '../widget/button/button_detail.dart';

class ListRiwayatTambak extends StatefulWidget {
  final String id;
  final String pondId;
  final String namePond;
  final String date;
  final VoidCallback onDownloadPressed;

  const ListRiwayatTambak({
    super.key,
    required this.id,
    required this.pondId,
    required this.date,
    required this.onDownloadPressed,
    required this.namePond,
  });

  @override
  _ListRiwayatTambakState createState() => _ListRiwayatTambakState();
}

class _ListRiwayatTambakState extends State<ListRiwayatTambak> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double textSize = constraints.maxWidth < 350 ? 12 : 14;
        double iconSize = constraints.maxWidth < 350 ? 20.0 : 22.0;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ Teks "Data Tambak {tanggal}"
              Expanded(
                child: Text(
                  '${widget.namePond} ${widget.date}',
                  style: GoogleFonts.inter(
                    fontSize: textSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF16425B),
                  ),
                  overflow: TextOverflow.ellipsis, // Menghindari teks kepanjangan
                ),
              ),
              Row(
                children: [
                  // ✅ Tombol Lihat Detail
                  ButtonDetail(
                    text: 'Lihat Detail',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanKualitasAir(
                            date: widget.date,
                            pondId: widget.pondId,
                            historyId: widget.id,
                            namePond: widget.namePond,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 15),

                  // ✅ Tombol Download dengan efek saat ditekan
                  InkWell(
                    onTapDown: (_) => setState(() => isPressed = true),
                    onTapUp: (_) => setState(() => isPressed = false),
                    onTapCancel: () => setState(() => isPressed = false),
                    onTap: widget.onDownloadPressed,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPressed
                            ? Colors.blue.withAlpha(50) // Efek transparan saat ditekan
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        LucideIcons.download,
                        color: const Color(0xFF16425B),
                        size: iconSize,
                      ),
                    ),
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
