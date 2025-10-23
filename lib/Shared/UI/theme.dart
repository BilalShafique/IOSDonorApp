// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme basicTextTheme(TextTheme base) {
    return base.copyWith(
      bodyLarge: const TextStyle(color: Colors.white),
      bodyMedium: const TextStyle(color: Colors.white),
      bodySmall: const TextStyle(color: Colors.white),
      headlineLarge: const TextStyle(color: Colors.white),
      headlineMedium: const TextStyle(color: Colors.white),
      headlineSmall: const TextStyle(color: Colors.white),
      titleLarge: const TextStyle(color: Colors.white),
      titleMedium: const TextStyle(color: Colors.white),
      titleSmall: const TextStyle(color: Colors.white),
      labelLarge: const TextStyle(color: Colors.white),
      labelMedium: const TextStyle(color: Colors.white),
      labelSmall: const TextStyle(color: Colors.white),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: basicTextTheme(base.textTheme),
      scaffoldBackgroundColor: const Color(0xFFF0F3F5),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white, // Set back button color to white
        ),
      ));
}
