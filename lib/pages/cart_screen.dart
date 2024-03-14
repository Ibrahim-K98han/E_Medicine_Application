import 'dart:convert';
import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/cart_model.dart';
import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/pages/main_screen.dart';
import 'package:e_medicine/pages/success_checkout.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../theme.dart';

class CartScreen extends StatefulWidget {
  CartScreen(this.method);
  final VoidCallback method;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final price = NumberFormat("#,#00", "EN_US");
  int delivery = 0;
  String? userID, fullName, address, phone;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
      fullName = sharedPreferences.getString(PrefProfile.name);
      address = sharedPreferences.getString(PrefProfile.address);
      phone = sharedPreferences.getString(PrefProfile.phone);
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listCart = [];
  getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID!);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  updateQuantity(String tipe, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http.post(urlUpdateQuantity, body: {
      "cartID": model,
      "tipe": tipe,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
        widget.method();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final response = await http.post(urlCheckout, body: {"idUser": userID});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return SuccessCheckout();
        },
      ), (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID!);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'].toString();
      setState(() {
        sumPrice = total;
        totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(24),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xfffcfcfc),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Items',
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                          color: greyBoldColor,
                        ),
                      ),
                      Text(
                        'Tk ${price.format(int.parse(sumPrice))}',
                        style: boldTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee',
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                          color: greyBoldColor,
                        ),
                      ),
                      Text(
                        delivery == 0 ? 'FREE' : 'Tk $delivery',
                        style: boldTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payment',
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                          color: greyBoldColor,
                        ),
                      ),
                      Text(
                        'Tk ${price.format(totalPayment)}',
                        style: boldTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: 'checkout now',
                      onTap: () {
                        checkout();
                      },
                    ),
                  )
                ],
              ),
            ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            bottom: 220,
          ),
          children: [
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
                    'My Cart',
                    style: regularTextStyle.copyWith(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            ),
            listCart.isEmpty || listCart.length == null
                ? Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(top: 50),
                    child: WidgetIllustration(
                      image: "assets/images/empty_cart_ilustration.png",
                      title: 'Oops, There are no products in your cart',
                      subtitle1: 'Your cart is still empty, browse the',
                      subtitle2: 'attractive products from E_Medicine',
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: MediaQuery.of(context).size.width,
                        child: ButtonPrimary(
                          text: 'shopping now',
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                                (route) => false);
                          },
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(24),
                    height: 166,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Destination',
                          style: regularTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                                color: greyBoldColor,
                              ),
                            ),
                            Text(
                              '$fullName',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                                color: greyBoldColor,
                              ),
                            ),
                            Text(
                              '$address',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                                color: greyBoldColor,
                              ),
                            ),
                            Text(
                              '$phone',
                              style: regularTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            ListView.builder(
              itemCount: listCart.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final x = listCart[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  color: whiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            x.image!,
                            width: 115,
                            height: 100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  x.name!.toUpperCase(),
                                  style:
                                      regularTextStyle.copyWith(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity("tambah", x.idCart!);
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: greenColor,
                                      ),
                                    ),
                                    Text(x.quantity!),
                                    IconButton(
                                      onPressed: () {
                                        updateQuantity("kurang", x.idCart!);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Color(0xfff0997a),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Tk ${price.format(int.parse(x.price!))}",
                                  style: boldTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
