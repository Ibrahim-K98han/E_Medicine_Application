import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  CardProduct({
    super.key,
    required this.imageProduct,
    required this.nameProduct,
    required this.price,
  });
  final String imageProduct;
  final String nameProduct;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            imageProduct,
            width: 115,
            height: 76,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            nameProduct,
            style: regularTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            price,
            style: boldTextStyle,
          )
        ],
      ),
    );
  }
}
