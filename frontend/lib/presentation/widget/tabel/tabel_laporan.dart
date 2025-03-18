import 'package:flutter/material.dart';
import '../../../../color/color_constant.dart';
import '../../../server/api_service.dart';

class LaporanTable extends StatefulWidget {
  final String id; // Menggunakan id sebagai parameter API

  const LaporanTable({super.key, required this.id});

  @override
  _LaporanTableState createState() => _LaporanTableState();
}

class _LaporanTableState extends State<LaporanTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  Future<List<Map<String, dynamic>>> _fetchLaporanData() async {
    try {
      if (widget.id.isEmpty) return []; // Cegah request jika id kosong

      final response = await ApiService.getHistoryById(widget.id);
      if (response != null && response["data"] is List) {
        return (response["data"] as List)
            .map((item) => {
          "waktu": item["time"] ?? "-",
          "suhu": (item["temperature"] as num?)?.toStringAsFixed(1) ?? "0.0",
          "ph": (item["pH"] as num?)?.toStringAsFixed(1) ?? "0.0",
          "salinitas": (item["salinity"] as num?)?.toStringAsFixed(1) ?? "0.0",
          "kekeruhan": (item["turbidity"] as num?)?.toStringAsFixed(1) ?? "0.0",
          "hujan": item["rain_status"] ?? false,
        })
            .toList();
      }
    } catch (e) {
      debugPrint("❌ Error fetching data: $e");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 475, // Menjaga batas tinggi agar tidak error
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchLaporanData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data tidak tersedia"));
          }

          List<Map<String, dynamic>> laporanData = snapshot.data!;

          return Scrollbar(
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
                        _buildHeaderCell("Waktu", 50),
                        _buildHeaderCell("Suhu \n(°C)", 40),
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
                        columns: List.generate(6, (index) => const DataColumn(label: SizedBox())),
                        rows: laporanData.map((data) {
                          return DataRow(
                            color: WidgetStateColor.resolveWith((states) => Colors.white),
                            cells: [
                              _buildDataCell(data["waktu"], 50),
                              _buildDataCell(data["suhu"], 40),
                              _buildDataCell(data["ph"], 30),
                              _buildDataCell(data["salinitas"], 50),
                              _buildDataCell(data["kekeruhan"], 65),
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
          );
        },
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
