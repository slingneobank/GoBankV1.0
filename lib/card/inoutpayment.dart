import 'package:flutter/material.dart';
import 'package:gobank/card/inoutrequested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import 'inouthistory.dart';
import 'inoutscheduled.dart';

class InOutPayment extends StatefulWidget {
  const InOutPayment({Key? key}) : super(key: key);

  @override
  State<InOutPayment> createState() => _InOutPaymentState();
}

class _InOutPaymentState extends State<InOutPayment>  with SingleTickerProviderStateMixin{
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
  List<Widget> tabs = [
    const InOutHistory(),
    const InOutScheduled(),
    const InOutrequested(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,

    );
  }
}
