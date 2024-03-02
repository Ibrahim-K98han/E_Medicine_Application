import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  CardCategory({
    super.key,
    required this.imageCategory,
    required this.nameCategory,
  });
  final String imageCategory;
  final String nameCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageCategory,
          width: 60,
        ),
        Text(
          nameCategory,
          style: mediumTextStyle.copyWith(
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
