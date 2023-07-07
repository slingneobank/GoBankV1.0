import 'package:flutter/material.dart';
import 'package:gobank/home/transfer/sendall.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colornotifire.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> with SingleTickerProviderStateMixin{

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
 // TabController? controller;
  // List<Widget> tabs = [
  //   const SendAll(),
  //   const SendAll(),
  //   const SendAll(),
  //   const SendAll(),
  // ];

  @override
  void initState() {
    super.initState();
    //controller = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      
    );
  }
}
