import 'package:flutter/material.dart';
import 'package:gobank/analytics/chatscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import 'chatround.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics>
    with SingleTickerProviderStateMixin {
  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  TabController? controller;

  int selectedindex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  List img = ["images/chart1.png", "images/chat2.png"];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: week(),
    );
  }

  Widget week() {
    return selectedindex == 0 ? const ChatScreen() : const ChatRound();
  }
}
