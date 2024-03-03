import 'package:e_medicine/network/model/product_model.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productModel.name!,
        ),
      ),
    );
  }
}
