import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/monitoring.dart';
import 'package:frontend_app/presentation/widget/button_monitoring.dart';
import 'package:frontend_app/presentation/widget/pond_menu_widget.dart';

class PondTile extends StatefulWidget {
  final String pondName;
  final String status;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PondTile({
    super.key,
    required this.pondName,
    required this.status,
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<PondTile> createState() => _PondTileState();
}

class _PondTileState extends State<PondTile> {
  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showMenu() {
    // Dapatkan posisi ikon titik tiga
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Area untuk menutup popup jika diklik di luar
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeMenu,
                behavior: HitTestBehavior.translucent,
              ),
            ),
            // Menampilkan menu di posisi yang benar
            Positioned(
              left: offset.dx - 100, // Geser ke kiri jika perlu agar tidak keluar dari PondTile
              top: offset.dy + renderBox.size.height + 5, // Posisi di bawah titik tiga
              child: Material(
                color: Colors.transparent,
                child: PondMenuWidget(
                  onEdit: () {
                    _removeMenu();
                    widget.onEdit();
                  },
                  onDelete: () {
                    _removeMenu();
                    widget.onDelete();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (Nama Kolam & Icon Titik Tiga)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.pondName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  key: _menuKey, // Pasang key untuk mendapatkan posisi
                  onTap: _showMenu,
                  child: const Icon(Icons.more_vert, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 2),

            // Status
            Text(
              widget.status,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 1),

            // Tanggal
            Text(
              widget.date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 2),

            // Tombol Monitoring
            Center(
              child: OutlinedButtonWidget(
                text: "Monitoring",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Monitoring()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
