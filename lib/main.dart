import 'package:e_medicine/pages/home_screen.dart';
import 'package:e_medicine/pages/splash_screen.dart';
import 'package:e_medicine/theme.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:e_medicine/widget/general_logo_space.dart';
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
      ),
      home: HomeScreen(),
    );
  }
}
