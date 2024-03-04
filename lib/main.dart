import 'package:e_medicine/pages/splash_screen.dart';
import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: greenColor,
        appBarTheme: AppBarTheme(
          backgroundColor: greenColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: whiteColor,
          selectedItemColor: greenColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
