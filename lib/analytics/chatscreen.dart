import 'package:flutter/material.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  @override
  void initState() {
    super.initState();
  }



  List historyimg = [
    "images/starbuckscoffee.png",
    "images/spotify.png",
    "images/netflix.png"
  ];

  int progressValue = 20;

  List recentimg = [
    "images/chart3.png",
    "images/chart4.png",
    "images/chart5.png"
  ];
  List recentname = [
    CustomStrings.grocery,
    CustomStrings.fooddrink,
    CustomStrings.entertaiment
  ];
  List historyname = [
    CustomStrings.starbuckscoffee,
    CustomStrings.spotifypremium,
    CustomStrings.spotifypremium
  ];
  List recentcolor = [
    Colors.green,
    Colors.red,
    Colors.red,
  ];
  List recentamount = [
    "+\$24.000","-\$64.000","-\$21.000"
  ];
  List historycolor = [
    Colors.red,
    Colors.green,
    Colors.green,
  ];

  List historyamount = [
    "-\$46.000","+\$17.000","+\$25.000"
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return const Scaffold(


    );
  }


}

