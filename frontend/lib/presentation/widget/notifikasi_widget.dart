import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color/color_constant.dart';

class NotifikasiWidget extends StatefulWidget {
  const NotifikasiWidget({super.key});

  @override
  _NotifikasiWidgetState createState() => _NotifikasiWidgetState();
}

class _NotifikasiWidgetState extends State<NotifikasiWidget> {
  final List<Map<String, dynamic>> notifikasiList = [
    {"jenis": "Peringatan", "judul": "Pakan Udang", "waktu": "15 Menit yang lalu", "deskripsi": "Pakan udang di dalam tabung hampir habis, harap segera isi ulang sebelum waktu pemberian pakan.", "warna": Colors.red},
    {"jenis": "Peringatan", "judul": "Kualitas Air", "waktu": "35 Menit yang lalu", "deskripsi": "Kualitas air menurun, segera periksa parameter.", "warna": Colors.red},
    {"jenis": "Pemberitahuan", "judul": "Parameter Sensor", "waktu": "50 Menit yang lalu", "deskripsi": "Sensor bekerja dengan baik.", "warna": Colors.amber},
    {"jenis": "Pemberitahuan", "judul": "Pelontar Pakan", "waktu": "1 Hari yang lalu", "deskripsi": "Pelontar pakan dalam kondisi normal.", "warna": Colors.amber},
    {"jenis": "Pemberitahuan", "judul": "Aerator", "waktu": "2 Hari yang lalu", "deskripsi": "Aerator berjalan normal.", "warna": Colors.amber},
    {"jenis": "Peringatan", "judul": "Pakan Udang", "waktu": "15 Menit yang lalu", "deskripsi": "Pakan udang di dalam tabung hampir habis, harap segera isi ulang sebelum waktu pemberian pakan.", "warna": Colors.red},
    {"jenis": "Peringatan", "judul": "Kualitas Air", "waktu": "35 Menit yang lalu", "deskripsi": "Kualitas air menurun, segera periksa parameter.", "warna": Colors.red},
    {"jenis": "Pemberitahuan", "judul": "Parameter Sensor", "waktu": "50 Menit yang lalu", "deskripsi": "Sensor bekerja dengan baik.", "warna": Colors.amber},
    {"jenis": "Pemberitahuan", "judul": "Pelontar Pakan", "waktu": "1 Hari yang lalu", "deskripsi": "Pelontar pakan dalam kondisi normal.", "warna": Colors.amber},
    {"jenis": "Pemberitahuan", "judul": "Aerator", "waktu": "2 Hari yang lalu", "deskripsi": "Aerator berjalan normal.", "warna": Colors.amber},
  ];

  int _currentPage = 0;
  static const int itemsPerPage = 6;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    int startIndex = _currentPage * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage).clamp(0, notifikasiList.length);
    List<Map<String, dynamic>> currentNotifikasi = notifikasiList.sublist(startIndex, endIndex);

    return Container(
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      decoration: BoxDecoration(
        color: const Color(0x80D9DCD6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: const Border(bottom: BorderSide(color: Colors.white)),
                    ),
                    child: ListView.separated(
                      itemCount: currentNotifikasi.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.white, height: 1),
                      itemBuilder: (context, index) {
                        final notif = currentNotifikasi[index];
                        bool isSelected = _selectedIndex == index;
                        return ListTile(
                          tileColor: isSelected ? Colors.blueAccent.withAlpha(75) : Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "[${notif["jenis"]}]\n",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const WidgetSpan(
                                  child: SizedBox(height: 18), // Jarak antara jenis dan judul
                                ),
                                TextSpan(
                                  text: notif["judul"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 1), // Jarak antara judul dan waktu
                            child: Text(
                              notif["waktu"],
                              style: TextStyle(fontSize: 11, color: ColorConstant.primary),
                            ),
                          ),

                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

                Container(width: 1, color: Colors.white),

                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: const Border(bottom: BorderSide(color: Colors.white)),
                    ),
                    padding: const EdgeInsets.only(top: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Hi, OwnerTambak",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorConstant.primary),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Ada pemberitahuan baru untuk anda", style: TextStyle(fontSize: 12, color: ColorConstant.primary),),
                        ),
                        const Divider(color: Colors.white),
                        _selectedIndex != null
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 15),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 6), // Jarak antara ikon dan teks
                                              child: Icon(
                                                currentNotifikasi[_selectedIndex!]["jenis"] == "Peringatan"
                                                    ? Icons.warning_amber_rounded
                                                    : Icons.notifications,
                                                color: currentNotifikasi[_selectedIndex!]["warna"],
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "[${currentNotifikasi[_selectedIndex!]["jenis"]}]\n",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: currentNotifikasi[_selectedIndex!]["warna"],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(height: 25), // Jarak antara jenis dan judul
                                      ),
                                      TextSpan(
                                        text: currentNotifikasi[_selectedIndex!]["judul"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                            color: currentNotifikasi[_selectedIndex!]["warna"],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  currentNotifikasi[_selectedIndex!]["deskripsi"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: currentNotifikasi[_selectedIndex!]["warna"],
                                  ),
                                ),
                              ),
                            ]
                        )
                            : Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Pilih notifikasi untuk melihat detail", style: TextStyle(fontSize: 14, color: ColorConstant.primary),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Color(0xFF16425B)),
                  onPressed: _currentPage > 0 ? () => setState(() => _currentPage--) : null,
                ),
                ...List.generate((notifikasiList.length / itemsPerPage).ceil(), (index) {
                  int pageNumber = index + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _currentPage = index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "$pageNumber",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: _currentPage == index ? FontWeight.bold : FontWeight.normal,
                          color: _currentPage == index ? Colors.blue : const Color(0xFF16425B),
                        ),
                      ),
                    ),
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Color(0xFF16425B)),
                  onPressed: endIndex < notifikasiList.length ? () => setState(() => _currentPage++) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
