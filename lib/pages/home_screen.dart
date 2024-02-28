import 'package:e_medicine/theme.dart';
import 'package:e_medicine/widget/card_category.dart';
import 'package:e_medicine/widget/card_product.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            Container(
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
            SizedBox(
              height: 32,
            ),
            Text(
              'Medicine & Vitamins by Category',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
