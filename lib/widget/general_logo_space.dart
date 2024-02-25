import 'package:flutter/material.dart';

class GeneralLogoSpace extends StatelessWidget {
  const GeneralLogoSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 115,
          )
        ],
      ),
    );
  }
}
