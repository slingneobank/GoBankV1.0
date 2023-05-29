import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/string.dart';

class Seeallpayment extends StatefulWidget {
  const Seeallpayment({Key? key}) : super(key: key);

  @override
  State<Seeallpayment> createState() => _SeeallpaymentState();
}

class _SeeallpaymentState extends State<Seeallpayment> {
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

  List insuranceimg = [
    "images/health.png",
    "images/mobile.png",
    "images/water.png",
    "images/ticket.png",
  ];

  List insurancename = [
    CustomStrings.health,
    CustomStrings.mobile,
    CustomStrings.motor,
    CustomStrings.car,
  ];

  List optionimg = [
    "images/assurance.png",
    "images/shopping.png",
    "images/deals.png",
    "images/install.png",
  ];

  List optionname = [
    CustomStrings.assurance,
    CustomStrings.shopping,
    CustomStrings.deals,
    CustomStrings.install,
  ];

  List img = [
    "images/bill.png",
    "images/wifi.png",
    "images/water.png",
    "images/wallet1.png",
    "images/game.png",
    "images/television.png",
    "images/merchant.png",
    "images/install.png",
  ];

  List paymentname = [
    CustomStrings.electricity,
    CustomStrings.internet,
    CustomStrings.water,
    CustomStrings.wallet,
    CustomStrings.games,
    CustomStrings.television,
    CustomStrings.merchant,
    CustomStrings.install,
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,

    );
  }
}
