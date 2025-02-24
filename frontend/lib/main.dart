import 'package:flutter/material.dart';
import 'package:frontend_app/presentation/pages/beranda.dart';
import 'package:frontend_app/presentation/pages/login.dart';
import 'package:frontend_app/presentation/pages/monitoring.dart';
import 'package:frontend_app/presentation/pages/profile.dart';
import 'package:frontend_app/presentation/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}


