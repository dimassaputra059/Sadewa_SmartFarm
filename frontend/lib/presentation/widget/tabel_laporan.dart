import 'package:flutter/material.dart';
import '../../../color/color_constant.dart';

class LaporanTable extends StatefulWidget {
  const LaporanTable({super.key});

  @override
  _LaporanTableState createState() => _LaporanTableState();
}

class _LaporanTableState extends State<LaporanTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  final List<Map<String, dynamic>> laporanData = [
    {"waktu": "07:00", "suhu": 28.5, "ph": 7.2, "salinitas": 30, "kekeruhan": 5, "hujan": true},
    {"waktu": "08:00", "suhu": 29.0, "ph": 7.3, "salinitas": 29, "kekeruhan": 6, "hujan": false},
    {"waktu": "09:00", "suhu": 30.2, "ph": 7.1, "salinitas": 28, "kekeruhan": 7, "hujan": true},
    {"waktu": "10:00", "suhu": 31.5, "ph": 7.4, "salinitas": 27, "kekeruhan": 8, "hujan": false},
    {"waktu": "11:00", "suhu": 32.0, "ph": 7.5, "salinitas": 26, "kekeruhan": 10, "hujan": false},
    {"waktu": "07:00", "suhu": 28.5, "ph": 7.2, "salinitas": 30, "kekeruhan": 5, "hujan": true},
    {"waktu": "08:00", "suhu": 29.0, "ph": 7.3, "salinitas": 29, "kekeruhan": 6, "hujan": false},
    {"waktu": "09:00", "suhu": 30.2, "ph": 7.1, "salinitas": 28, "kekeruhan": 7, "hujan": true},
    {"waktu": "10:00", "suhu": 31.5, "ph": 7.4, "salinitas": 27, "kekeruhan": 8, "hujan": false},
    {"waktu": "11:00", "suhu": 32.0, "ph": 7.5, "salinitas": 26, "kekeruhan": 10, "hujan": false},
    {"waktu": "07:00", "suhu": 28.5, "ph": 7.2, "salinitas": 30, "kekeruhan": 5, "hujan": true},
    {"waktu": "08:00", "suhu": 29.0, "ph": 7.3, "salinitas": 29, "kekeruhan": 6, "hujan": false},
    {"waktu": "09:00", "suhu": 30.2, "ph": 7.1, "salinitas": 28, "kekeruhan": 7, "hujan": true},
    {"waktu": "10:00", "suhu": 31.5, "ph": 7.4, "salinitas": 27, "kekeruhan": 8, "hujan": false},
    {"waktu": "11:00", "suhu": 32.0, "ph": 7.5, "salinitas": 26, "kekeruhan": 10, "hujan": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 475, // **Batas tinggi agar tidak error**
      child: Scrollbar(
        controller: _verticalController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _horizontalController,
          child: Column(
            children: [
              // Header Table
              Container(
                color: ColorConstant.primary,
                child: DataTable(
                  border: TableBorder.all(color: Colors.grey.shade400),
                  headingRowHeight: 50,
                  columns: [
                    _buildHeaderCell("Waktu", 40),
                    _buildHeaderCell("Suhu \n(°C)", 30),
                    _buildHeaderCell("pH", 30),
                    _buildHeaderCell("Salinitas \n(ppt)", 50),
                    _buildHeaderCell("Kekeruhan \n(NTU)", 65),
                    _buildHeaderCell("Hujan", 40),
                  ],
                  rows: const [], // Header tanpa data
                ),
              ),
              // Isi Table (Scrollable Vertikal)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _verticalController,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.grey.shade400),
                    showCheckboxColumn: false,
                    headingRowHeight: 0, // Header Kosong
                    columns: [
                      DataColumn(label: SizedBox(child: Text(''))),
                      DataColumn(label: SizedBox(child: Text(''))),
                      DataColumn(label: SizedBox(child: Text(''))),
                      DataColumn(label: SizedBox(child: Text(''))),
                      DataColumn(label: SizedBox(child: Text(''))),
                      DataColumn(label: SizedBox(child: Text(''))),
                    ],
                    rows: laporanData.map((data) {
                      return DataRow(
                        color: WidgetStateColor.resolveWith((states) => Colors.white),
                        cells: [
                          _buildDataCell(data["waktu"], 40),
                          _buildDataCell(data["suhu"].toString(), 30),
                          _buildDataCell(data["ph"].toString(), 30),
                          _buildDataCell(data["salinitas"].toString(), 50),
                          _buildDataCell(data["kekeruhan"].toString(), 65),
                          _buildDataCell(_convertHujanToText(data["hujan"]), 40),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataColumn _buildHeaderCell(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String data, double width) {
    return DataCell(
      SizedBox(
        width: width,
        child: Center(
          child: Text(data, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  String _convertHujanToText(bool? value) {
    return value == true ? "Ya" : "Tidak";
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }
}
