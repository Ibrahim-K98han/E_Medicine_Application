import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final priceFormat = NumberFormat('#,#00', 'EN_US');
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 115,
            height: 76,
          ),
          Expanded(
            flex: 2,
            child: Text(
              nameProduct,
              style: regularTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Price : ${priceFormat.format(
              int.parse(price),
            )} Tk',
            style: boldTextStyle,
          )
        ],
      ),
    );
  }
}
