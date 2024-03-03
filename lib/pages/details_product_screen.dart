import 'package:e_medicine/network/model/product_model.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class DetailsProductScreen extends StatefulWidget {
  DetailsProductScreen({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final priceFormat = NumberFormat('#,#00', 'EN_US');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          height: 70,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 32,
                  color: greenColor,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                'Detail Product',
                style: regularTextStyle.copyWith(
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Container(
          height: 200,
          color: whiteColor,
          child: Image.network(
            widget.productModel.image!,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.productModel.name!,
                style: regularTextStyle.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.productModel.description!,
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                  color: greyBoldColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 64,
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Price : ${priceFormat.format(
                      int.parse(widget.productModel.price!),
                    )} Tk',
                    style: boldTextStyle.copyWith(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonPrimary(
                  onTap: () {},
                  text: 'add to cart',
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
