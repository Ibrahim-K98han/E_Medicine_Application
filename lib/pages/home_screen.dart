import 'dart:convert';
import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/network/model/product_model.dart';
import 'package:e_medicine/pages/cart_screen.dart';
import 'package:e_medicine/pages/details_product_screen.dart';
import 'package:e_medicine/pages/search_product_screen.dart';
import 'package:e_medicine/theme.dart';
import 'package:e_medicine/widget/card_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/card_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? i;
  bool filter = false;
  bool dataLoadingInProgress = false;
  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    dataLoadingInProgress = true;
    listCategory.clear();
    setState(() {});
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    final response = await http.get(urlCategory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          listCategory.add(CategoryWithProduct.fromJson(item));
        }
      });
      dataLoadingInProgress = false;
      setState(() {});
      getProduct();
      totalCart();
    }
  }

  List<ProductModel> listProduct = [];
  getProduct() async {
    dataLoadingInProgress = true;
    listProduct.clear();

    setState(() {});
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
    dataLoadingInProgress = false;
    setState(() {});
  }

  String? userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
    });
  }

  var totalAmount = "0";
  totalCart() async {
    var urlGetTotalCart = Uri.parse(BASEURL.getTotalCart + userID!);
    final respone = await http.get(urlGetTotalCart);
    if (respone.statusCode == 200) {
      final data = jsonDecode(respone.body)[0];
      String total = data['Amount'];
      setState(() {
        totalAmount = total;
      });
    }
  }

  @override
  void initState() {
    getCategory();
    getPref();
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
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(totalCart),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: greenColor,
                      ),
                    ),
                    totalAmount == "0"
                        ? const SizedBox()
                        : Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  totalAmount,
                                  style: regularTextStyle.copyWith(
                                    color: whiteColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
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
                        physics: const ClampingScrollPhysics(),
                        itemCount: listCategory[i!].product!.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          // final y = listCategory[i!].product![index];
                          final y = listCategory[i!].product![index];
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
                      )
                : dataLoadingInProgress
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        physics: const ClampingScrollPhysics(),
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
