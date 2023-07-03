import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/home/scanpay/scan.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';
import '../card/mycard.dart';
import '../profile/profile.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  late ColorNotifire notifire;
  int currentTab = 0;
  bool keyboardOpen = false;

  final List screens = [
   const  Home(),
  const  Analytics(),
   const   MyCard(),
    const  Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Home();

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
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     setState(() => keyboardOpen = visible);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: notifire.getprimerycolor,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: notifire.getbluecolor,
          child: Image.asset(
            "images/scan1.png",
            height: height / 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scan(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: notifire.getprimerydarkcolor,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 30,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = const Home();
                            currentTab = 0;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 0
                              ? Image.asset(
                                  "images/home1.png",
                                  height: height / 34,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset(
                                  "images/home.png",
                                  height: height / 33,
                            color: notifire.getdarkscolor,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = const Analytics();
                            currentTab = 1;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 1
                              ? Image.asset(
                                  "images/order1.png",
                                  height: height / 33,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset(
                                  "images/variant.png",
                                  height: height / 33,color: notifire.getdarkscolor
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = const MyCard();
                            currentTab = 3;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 3
                              ? Image.asset(
                                  "images/wallet.png",
                                  height: height / 30,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset(
                                  "images/message1.png",
                                  height: height / 30,color: notifire.getdarkscolor
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(
                          () {
                            currentScreen = const Profile();
                            currentTab = 4;
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentTab == 4
                              ? Image.asset(
                                  "images/profile1.png",
                                  height: height / 30,
                                  color: notifire.getbluecolor,
                                )
                              : Image.asset(
                                  "images/profile.png",
                                  height: height / 30,color: notifire.getdarkscolor
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
