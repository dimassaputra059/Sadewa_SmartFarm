import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import '../pages/profile.dart';
import '../widget/profile_widget.dart';

class MainHeaderWidget extends StatefulWidget {
  const MainHeaderWidget({super.key});

  @override
  State<MainHeaderWidget> createState() => _MainHeaderWidgetState();
}

class _MainHeaderWidgetState extends State<MainHeaderWidget> {
  late String _currentTime;
  late String _currentDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
  }

  void _initializeDateFormatting() async {
    await initializeDateFormatting('id_ID', null);
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat.Hms().format(now);
      _currentDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentTime,
                    style: TextStyle(
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _currentDate,
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ProfileButtonWidget(
                username: "OwnerTambak",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
