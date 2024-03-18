import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? fullName, createdDate, phone, email, address;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(PrefProfile.name);
      createdDate = sharedPreferences.getString(PrefProfile.createdAt);
      phone = sharedPreferences.getString(PrefProfile.phone);
      email = sharedPreferences.getString(PrefProfile.email);
      address = sharedPreferences.getString(PrefProfile.address);
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Profile',
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
                Icon(
                  Icons.exit_to_app,
                  color: greenColor,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName.toString(),
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Join At: $createdDate',
                  style: lightTextStyle,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone',
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  phone.toString(),
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  email.toString(),
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address',
                  style: lightTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  address.toString(),
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
