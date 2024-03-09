import 'dart:convert';

import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/pages/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import '../widget/button_primary.dart';
import '../widget/general_logo_space.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      'email': emailController.text,
      'password': passwordController.text
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String name = data['name'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String createdAt = data['created_at'];
    if (value == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Information'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                    (route) => false);
                print(name);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Information'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      setState(() {});
    }
  }

  savePref(
    String idUser,
    String name,
    String email,
    String phone,
    String address,
    String createdAt,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.idUser, idUser);
      sharedPreferences.setString(PrefProfile.name, name);
      sharedPreferences.setString(PrefProfile.email, email);
      sharedPreferences.setString(PrefProfile.phone, phone);
      sharedPreferences.setString(PrefProfile.address, address);
      sharedPreferences.setString(PrefProfile.createdAt, createdAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const GeneralLogoSpace(),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'login'.toUpperCase(),
                  style: regularTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Login into your account',
                  style: regularTextStyle.copyWith(
                    fontSize: 15,
                    color: greyLightColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x04000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,
                        color: greyLightColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x04000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText
                            ? const Icon(
                                Icons.visibility_off,
                                size: 20,
                              )
                            : const Icon(
                                Icons.visibility,
                                size: 20,
                              ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,
                        color: greyLightColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    onTap: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning !!'),
                            content: Text('Please, Enter The Fields'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        submitLogin();
                      }
                    },
                    text: 'login',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: lightTextStyle.copyWith(
                        color: greyLightColor,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ));
                      },
                      child: Text(
                        'Create Account',
                        style: boldTextStyle.copyWith(
                          color: greenColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
