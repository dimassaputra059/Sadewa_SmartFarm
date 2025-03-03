import 'package:flutter/material.dart';
import '../../../../color/color_constant.dart';
import '../../pages/manajemen/user/edit_user.dart';

class UserManagementTable extends StatefulWidget {
  final double headerHeight;

  const UserManagementTable({super.key, this.headerHeight = 40.0});

  @override
  _UserManagementTableState createState() => _UserManagementTableState();
}

class _UserManagementTableState extends State<UserManagementTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  List<Map<String, String>> users = List.generate(
    20,
        (index) => {
      'username': 'User$index',
      'email': 'user$index@gmail.com',
      'role': index % 2 == 0 ? 'Admin' : 'User',
      'createdAt': '0${(index % 9) + 1}/03/2025',
    },
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double usernameWidth = screenWidth * 0.4;
    double emailWidth = screenWidth * 0.4;
    double roleWidth = screenWidth * 0.2;
    double createdAtWidth = screenWidth * 0.3;
    double actionColumnWidth = screenWidth * 0.3;
    double tableWidth = usernameWidth + emailWidth + roleWidth + createdAtWidth + actionColumnWidth;

    return Column(
      children: [
        // Wrapper untuk scroll horizontal
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: tableWidth),
              child: Column(
                children: [
                  // Header Tabel (Tetap Saat Scroll Vertikal)
                  Container(
                    color: ColorConstant.primary,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey.shade400),
                      headingRowHeight: widget.headerHeight,
                      columns: [
                        _buildHeaderCell("Username", usernameWidth),
                        _buildHeaderCell("Email", emailWidth),
                        _buildHeaderCell("Role", roleWidth),
                        _buildHeaderCell("Tanggal Buat", createdAtWidth),
                        _buildHeaderCell("Action", actionColumnWidth),
                      ],
                      rows: const [], // Header saja, data ada di bawah
                    ),
                  ),
                  // Isi Tabel (Hanya Bisa Scroll Vertikal)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _verticalScrollController,
                      child: DataTable(
                        border: TableBorder.all(color: Colors.grey.shade400),
                        showCheckboxColumn: false,
                        headingRowHeight: 0, // Menyembunyikan header di bagian isi tabel
                        columns: [
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                        ],
                        rows: users.map((user) {
                          return DataRow(
                            color: WidgetStateColor.resolveWith((states) => Colors.white),
                            cells: [
                              _buildDataCell(user['username']!, usernameWidth),
                              _buildDataCell(user['email']!, emailWidth),
                              _buildDataCell(user['role']!, roleWidth),
                              _buildDataCell(user['createdAt']!, createdAtWidth),
                              DataCell(_buildActionButtons(user)),
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
        ),
      ],
    );
  }

  DataColumn _buildHeaderCell(String label, double width) {
    return DataColumn(
      label: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String data, double width) {
    return DataCell(
      Container(
        width: width,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        color: Colors.white,
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, String> user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(Icons.edit, Colors.green, () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditUser(
                username: user['username']!,
                email: user['email']!,
                role: user['role']!,
              ),
            ),
          );
        }),
        const SizedBox(width: 20),
        _buildActionButton(Icons.delete, Colors.red, () {
          _deleteUser(user);
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 40,
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onTap,
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }

  void _deleteUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah Anda yakin ingin menghapus pengguna ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users.remove(user);
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Hapus",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
