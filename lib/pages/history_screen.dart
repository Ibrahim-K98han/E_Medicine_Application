import 'dart:convert';

import 'package:e_medicine/network/api/url_api.dart';
import 'package:e_medicine/network/model/history_model.dart';
import 'package:e_medicine/network/model/pref_profile.dart';
import 'package:e_medicine/widget/card_history.dart';
import 'package:e_medicine/widget/widget_ilustration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryOrderDetailModel> list = [];
  String? userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID!);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          list.add(HistoryOrderDetailModel.fromJson(item));
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
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 70,
                child: Text(
                  'History Order',
                  style: regularTextStyle.copyWith(
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: list.isEmpty ? 80 : 20,
              ),
              list.isEmpty
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: WidgetIllustration(
                          image: 'assets/images/no_history_ilustration.png',
                          title: 'You don\t have history order',
                          subtitle1: 'lets shopping now',
                          subtitle2: 'Oops, there are no history order',
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final x = list[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 8),
                          child: CardHistory(
                            model: x,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
