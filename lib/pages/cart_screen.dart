import 'dart:convert';

import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/cart_model.dart';
import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
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
                  'Tk 180.000',
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
                  'TK $delivery',
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
                onTap: () {},
              ),
            )
          ],
        ),
      ),
      body: ListView(
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
          Container(
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
                                style: regularTextStyle.copyWith(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: greenColor,
                                    ),
                                  ),
                                  Text(x.quantity!),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Color(0xfff0997a),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                x.price!.toUpperCase(),
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
    );
  }
}
