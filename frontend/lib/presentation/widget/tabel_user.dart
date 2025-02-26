import 'package:flutter/material.dart';
import '../../color/color_constant.dart';
import '../pages/edit_user.dart';

class UserManagementTable extends StatefulWidget {
  final List<Map<String, String>> users;
  final double headerHeight;

  const UserManagementTable({
    super.key,
    required this.users,
    this.headerHeight = 40.0,
  });

  @override
  _UserManagementTableState createState() => _UserManagementTableState();
}

class _UserManagementTableState extends State<UserManagementTable> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double actionColumnWidth = screenWidth * 0.35;
    double usernameWidth = screenWidth * 0.25;
    double emailWidth = screenWidth * 0.45;
    double roleWidth = screenWidth * 0.1;
    double createdAtWidth = screenWidth * 0.25;

    if (widget.users.isEmpty) {
      return const Center(
        child: Text(
          "Data user kosong",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true, // Scrollbar selalu terlihat
      trackVisibility: true, // Garis track scrollbar selalu terlihat
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: DataTable(
            border: TableBorder.all(color: Colors.grey.shade400),
            headingRowHeight: widget.headerHeight,
            headingRowColor: WidgetStateColor.resolveWith((states) => ColorConstant.primary),
            columns: [
              DataColumn(
                label: SizedBox(
                  width: usernameWidth,
                  child: const Center(
                    child: Text(
                      'Username',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: emailWidth,
                  child: const Center(
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: roleWidth,
                  child: const Center(
                    child: Text(
                      'Role',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: createdAtWidth,
                  child: const Center(
                    child: Text(
                      'Tanggal Buat',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: actionColumnWidth,
                  child: const Center(
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
            rows: widget.users.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> user = entry.value;

              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return Colors.white;
                  },
                ),
                cells: [
                  DataCell(Center(child: Text(user['username']!))),
                  DataCell(Center(child: Text(user['email']!))),
                  DataCell(Center(child: Text(user['role']!))),
                  DataCell(Center(child: Text(user['createdAt']!))),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 48,
                              height: 36,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return const Color(0xFF81C3D7);
                                    }
                                    return Colors.green;
                                  }),
                                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(
                                        username: user['username']!,
                                        email: user['email']!,
                                        role: user['role']!,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.edit, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: SizedBox(
                              width: 48,
                              height: 36,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return const Color(0xFF81C3D7);
                                    }
                                    return Colors.red;
                                  }),
                                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Aksi hapus user
                                },
                                child: const Icon(Icons.delete, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
