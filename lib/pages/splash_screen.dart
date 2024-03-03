import 'package:e_medicine/pages/login_screen.dart';
import 'package:e_medicine/pages/main_screen.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:e_medicine/widget/general_logo_space.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/model/pref_profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString(PrefProfile.idUser);
      userId == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            WidgetIllustration(
              image: 'assets/images/splash_ilustration.png',
              title: 'Find your medical\nsolution',
              subtitle1: 'Consult with a doctor',
              subtitle2: 'whereever and whenever you want',
              child: ButtonPrimary(
                text: 'get started',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
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
