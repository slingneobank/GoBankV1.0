import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gobank/apicalling/generatoken.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/home/sling_store/sling_store.dart';
import 'package:gobank/home/sling_store/sling_storemain.dart';
import 'package:gobank/login/login.dart';
import 'package:gobank/login/loginCheck.dart';
import 'package:gobank/onbonding.dart';
import 'package:gobank/slingsaverclub/bannerpage.dart';
import 'package:gobank/slingsaverclub/demo.dart';
import 'package:gobank/slingsaverclub/sliderpage.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          builder: (context) => LoginCheck(),
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
