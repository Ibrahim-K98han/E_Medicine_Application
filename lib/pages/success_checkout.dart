import 'package:e_medicine/pages/main_screen.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:e_medicine/widget/general_logo_space.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(24),
          children: [
            const SizedBox(
              height: 80,
            ),
            WidgetIllustration(
              image: 'assets/images/order_success_ilustration.png',
              title: 'Yeah, your order was successful',
              subtitle1: 'Consult with a doctors',
              subtitle2: 'Wherever and whenever you are',
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonPrimary(
              text: 'back to home',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                    (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
