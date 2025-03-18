import 'package:flutter/material.dart';
import 'package:frontend_app/color/color_constant.dart';
import 'package:intl/intl.dart';
import '../../../server/api_service.dart';
import '../../pages/manajemen/user/edit_user.dart';
import '../pop_up/custom_dialog.dart';
import '../pop_up/custom_dialog_button.dart';

class UserManagementTable extends StatefulWidget {
  const UserManagementTable({super.key});

  @override
  UserManagementTableState createState() => UserManagementTableState();
}

class UserManagementTableState extends State<UserManagementTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void refreshData() {
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<Map<String, dynamic>> fetchedUsers = await ApiService.getUsers();
    setState(() {
      _users = fetchedUsers;
    });
  }

  String formatTanggal(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      return "Format Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Tentukan lebar kolom agar header & data sama
    double usernameWidth = screenWidth * 0.3;
    double emailWidth = screenWidth * 0.5;
    double roleWidth = screenWidth * 0.15;
    double createdAtWidth = screenWidth * 0.2;
    double actionColumnWidth = screenWidth * 0.3;
    double tableWidth =
        usernameWidth + emailWidth + roleWidth + createdAtWidth + actionColumnWidth;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: tableWidth),
              child: Column(
                children: [
                  _buildTableHeader(usernameWidth, emailWidth, roleWidth, createdAtWidth, actionColumnWidth),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _verticalScrollController,
                      child: _buildTableBody(usernameWidth, emailWidth, roleWidth, createdAtWidth, actionColumnWidth),
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

  /// 🔹 **Header tabel dengan ukuran tetap**
  Widget _buildTableHeader(double usernameW, double emailW, double roleW, double createdAtW, double actionW) {
    return Container(
      color: ColorConstant.primary,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey.shade400),
        headingRowHeight: 40,
        columns: [
          _buildHeaderCell("Username", usernameW),
          _buildHeaderCell("Email", emailW),
          _buildHeaderCell("Role", roleW),
          _buildHeaderCell("Tanggal Buat", createdAtW),
          _buildHeaderCell("Action", actionW),
        ],
        rows: const [],
      ),
    );
  }

  /// 🔹 **Isi tabel dengan ukuran tetap**
  Widget _buildTableBody(double usernameW, double emailW, double roleW, double createdAtW, double actionW) {
    return DataTable(
      border: TableBorder.all(color: Colors.grey.shade400),
      showCheckboxColumn: false,
      headingRowHeight: 0,
      columns: List.generate(5, (_) => const DataColumn(label: Text(''))),
      rows: _users.map((user) {
        return DataRow(
          color: WidgetStateColor.resolveWith((states) => Colors.white),
          cells: [
            _buildDataCell(user['username'], usernameW),
            _buildDataCell(user['email'], emailW),
            _buildDataCell(user['role'], roleW),
            _buildDataCell(formatTanggal(user['createdAt']), createdAtW),
            DataCell(_buildActionButtons(user, actionW)),
          ],
        );
      }).toList(),
    );
  }

  /// 🔹 **Header cell dengan ukuran tetap**
  DataColumn _buildHeaderCell(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Center(
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
      ),
    );
  }

  /// 🔹 **Data cell dengan ukuran tetap**
  DataCell _buildDataCell(String data, double width) {
    return DataCell(
      SizedBox(
        width: width,
        child: Center(
          child: Text(
            data,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  /// 🔹 **Tombol aksi (edit & delete)**
  Widget _buildActionButtons(Map<String, dynamic> user, double width) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(Icons.edit, Colors.green, () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditUser(
                  userId: user['_id'],
                  username: user['username'],
                  email: user['email'],
                  role: user['role'],
                  onUpdateSuccess: _fetchUsers,
                ),
              ),
            );
          }),
          const SizedBox(width: 10),
          _buildActionButton(Icons.delete, Colors.red, () {
            _deleteUser(user);
          }),
        ],
      ),
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

  /// 🔹 **Fungsi hapus user**
  void _deleteUser(Map<String, dynamic> user) {
    CustomDialogButton.show(
      context: context,
      title: "Konfirmasi Hapus",
      message: "Apakah Anda yakin ingin menghapus pengguna ini?",
      confirmText: "Hapus",
      cancelText: "Batal",
      isWarning: true,
      onConfirm: () async {
        bool success = await ApiService.deleteUser(user['_id']);

        if (success) {
          _fetchUsers();
        }

        CustomDialog.show(
          context: context,
          isSuccess: success,
          message: success ? "Pengguna berhasil dihapus" : "Gagal menghapus pengguna",
        );
      },
    );
  }
}
