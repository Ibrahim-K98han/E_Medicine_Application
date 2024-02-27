import 'package:e_medicine/pages/registration_screen.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:e_medicine/widget/general_logo_space.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: Column(
          children: [
            const SizedBox(
              height: 45,
            ),
            WidgetIlustraion(
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
                      builder: (context) => RegistrationScreen(),
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
