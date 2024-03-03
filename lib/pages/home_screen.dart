import 'dart:convert';

import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/product_model.dart';
import 'package:e_medicine/pages/details_product_screen.dart';
import 'package:e_medicine/pages/search_product_screen.dart';
import 'package:e_medicine/theme.dart';
import 'package:e_medicine/widget/card_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? i;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      getProduct();
    }
  }

  List<ProductModel> listProduct = [];
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

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 155,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Find a medicine or\nvitamins with E-MEDICINE',
                      style: regularTextStyle.copyWith(
                        fontSize: 15,
                        color: greyBoldColor,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: greenColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchProductScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffe4faf0),
                ),
                child: TextField(
                  enabled: false,
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
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Medicine & Vitamins by Category',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GridView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: listCategory.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final x = listCategory[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      i = index;
                      filter = true;
                      print('$i, $filter');
                    });
                  },
                  child: CardCategory(
                    imageCategory: x.image.toString(),
                    nameCategory: x.category.toString(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            filter
                ? i == 7
                    ? const Text('Feature on progress')
                    : GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: listCategory[i!].product!.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          final y = listCategory[i!].product![index];
                          return CardProduct(
                            imageProduct: y.image!,
                            nameProduct: y.name!,
                            price: y.price!,
                          );
                        },
                      )
                : GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final y = listProduct[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsProductScreen(productModel: y),
                            ),
                          );
                        },
                        child: CardProduct(
                          imageProduct: y.image!,
                          nameProduct: y.name!,
                          price: y.price!,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
