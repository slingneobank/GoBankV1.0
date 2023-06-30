import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gobank/card/inouthistory.dart';
import 'package:gobank/card/inoutpayment.dart';
import 'package:gobank/card/inoutscheduled.dart';
import 'package:gobank/card/mycard.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/home/loan/eligibility_loan.dart';
import 'package:gobank/home/loan/pendingapproval.dart';
import 'package:gobank/home/loan/personalloan_form.dart';
import 'package:gobank/home/topup/topupcard/topup.dart';
import 'package:gobank/login/minkycpage.dart';
import 'package:gobank/login/verify.dart';

import 'package:gobank/onbonding.dart';
import 'package:gobank/pages/CardDetails.dart';
import 'package:gobank/pages/digitalcard_detail.dart';
import 'package:gobank/pages/history.dart';


import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/verification/verificationdone.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'card/createxcard.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late ColorNotifire notifire;
  //final authCtrl = Get.put<AuthCtrl>(AuthCtrl());

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
    getdarkmodepreviousstate();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Onbonding(),//onbonding  
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.transparent,
                height: height,
                width: width,
                child: Container(
                  color: Colors.white,
                ),
                // Image.asset(
                //   "images/splash.png",
                //   fit: BoxFit.cover,
                // ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height / 2.4,
                  ),
                  Center(
                    child: Image.asset(
                      "images/logo1.png",
                      height: height / 7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
