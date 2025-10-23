import 'package:donor_app/Shared/UI/splash.dart';
import 'package:donor_app/Shared/UI/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Donor App',
      theme: basicTheme(),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
