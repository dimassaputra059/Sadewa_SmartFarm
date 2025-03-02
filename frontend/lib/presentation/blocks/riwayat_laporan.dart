import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../color/color_constant.dart';
import '../widget/data_riwayat_widget.dart';
import '../widget/input/search_date_widget.dart';

class RiwayatLaporan extends StatefulWidget {
  const RiwayatLaporan({super.key});

  @override
  _RiwayatLaporanState createState() => _RiwayatLaporanState();
}

class _RiwayatLaporanState extends State<RiwayatLaporan> {
  int currentPage = 1;
  final int itemsPerPage = 6; // Jumlah item per halaman
  final List<String> allDates = List.generate(20, (index) =>
  "${(6 + index).toString().padLeft(2, '0')}/02/2025"); // Simulasi data

  List<String> filteredDates = []; // Data yang sudah difilter
  String? selectedDate; // Tanggal yang dipilih user

  @override
  void initState() {
    super.initState();
    filteredDates = List.from(allDates); // Awalnya tampilkan semua data
  }

  void _filterData(DateTime date) {
    setState(() {
      selectedDate = "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";

      // **Filter hanya data yang sesuai dengan tanggal yang dipilih**
      filteredDates = allDates.where((d) => d == selectedDate).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (filteredDates.length / itemsPerPage).ceil();
    List<String> displayedData = filteredDates
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double fontSize = screenWidth < 350 ? 14 : 16;
        double iconSize = screenWidth < 350 ? 18 : 20;
        double paddingSize = screenWidth < 350 ? 12.0 : 15.0;

        return Container(
          padding: EdgeInsets.only(top: paddingSize * 2, left: paddingSize, right: paddingSize),
          decoration: BoxDecoration(
            color: const Color(0x80D9DCD6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Input Tanggal Tanpa Tombol Cari**
              Row(
                children: [
                  Text(
                    "Cari Data Tambak :",
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: SearchDateWidget(onDateSelected: _filterData)),
                ],
              ),
              const SizedBox(height: 15),

              // **Cek apakah data tersedia**
              filteredDates.isEmpty
                  ? Center(
                child: Text(
                  "Data tidak ditemukan",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.primary,
                  ),
                ),
              )
                  : Column(
                children: [
                  // **List Data dengan Divider**
                  SizedBox(
                    height: itemsPerPage * 63, // Responsif tinggi daftar data
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Hindari scrolling dalam scrolling
                      itemCount: displayedData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            DataWidget(
                              date: displayedData[index],
                              onDetailPressed: () {},
                              onDownloadPressed: () {},
                            ),
                            if (index < displayedData.length )
                              const Divider(), // Divider hanya untuk item yang bukan terakhir
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // **Navigasi Halaman (Pagination)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left, color: const Color(0xFF16425B), size: iconSize),
                        onPressed: currentPage > 1
                            ? () => setState(() => currentPage--)
                            : null,
                      ),
                      ...List.generate(totalPages, (index) {
                        int pageNumber = index + 1;
                        return GestureDetector(
                          onTap: () => setState(() => currentPage = pageNumber),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth < 350 ? 5.0 : 8.0),
                            child: Text(
                              "$pageNumber",
                              style: GoogleFonts.inter(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w500,
                                color: pageNumber == currentPage
                                    ? Colors.blue
                                    : const Color(0xFF16425B),
                              ),
                            ),
                          ),
                        );
                      }),
                      IconButton(
                        icon: Icon(Icons.chevron_right, color: const Color(0xFF16425B), size: iconSize),
                        onPressed: currentPage < totalPages
                            ? () => setState(() => currentPage++)
                            : null,
                      ),
                    ],
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
