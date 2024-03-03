import 'dart:convert';
import 'package:e_medicine/network/model/product_model.dart';
import 'package:e_medicine/theme.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../network/api/url_api.dart';
import '../widget/card_product.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  searchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.name!.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  height: 55,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffe4faf0),
                  ),
                  child: TextField(
                    onChanged: searchProduct,
                    controller: searchController,
                    enabled: true,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xffb1d8b2),
                      ),
                      hintText: 'Search Medicine...',
                      hintStyle: regularTextStyle.copyWith(
                        color: const Color(
                          0xffb0d8b2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          searchController.text.isEmpty || listSearchProduct.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 100,
                  ),
                  child: WidgetIllustration(
                    image: 'assets/images/no_data_ilustration.png',
                    title: 'There is no medicine that is looking for',
                    subtitle1: 'Please find the product you want',
                    subtitle2: 'The Product will appear here',
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(24),
                  child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listSearchProduct.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final y = listSearchProduct[index];
                      return CardProduct(
                        imageProduct: y.image!,
                        nameProduct: y.name!,
                        price: y.price!,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
