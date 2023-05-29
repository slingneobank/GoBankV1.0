import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class Notificationindex extends StatefulWidget {
  final String title;
  const Notificationindex(this.title, {Key? key}) : super(key: key);

  @override
  State<Notificationindex> createState() => _NotificationindexState();
}

class _NotificationindexState extends State<Notificationindex> {
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

  List notificationtxt = [
    CustomStrings.successfully,
    CustomStrings.lockdown,
    CustomStrings.wayorder,
    CustomStrings.prepared,
    CustomStrings.discount,
  ];
  List notificationtxt2 = [
    CustomStrings.yesterday,
    CustomStrings.mar,
    CustomStrings.mar1,
    CustomStrings.mar2,
    CustomStrings.mar3,
  ];
  List notificationimg = [
    "images/successfull.png",
    "images/lockdown.png",
    "images/order.png",
    "images/banktransfer.png",
    "images/bankinsurance.png",
  ];
  List notificationclr = [
    const Color(0xff4BD37B),
    const Color(0xff10AFFF),
    const Color(0xffFFA03C),
    const Color(0xff8349FF),
    const Color(0xff10AFFF),
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/background.png",
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(
                  height: height / 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CustomStrings.notification,
                        style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy Bold',
                          fontSize: height / 40,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Column(
                    children: [
                      Container(
                        height: height / 1.5,
                        width: width,
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: notificationtxt.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => Column(
                            children: [
                              not(
                                notificationclr[index],
                                notificationimg[index],
                                notificationtxt[index],
                                notificationtxt2[index],
                              ),
                              SizedBox(
                                height: height / 60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget not(clr, img, txt, txt2) {
    return Container(
      height: height / 11,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: notifire.gettabwhitecolor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: width / 35,
          ),
          Container(
            height: height / 15,
            width: width / 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: clr,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(height / 70),
                child: Image.asset(img),
              ),
            ),
          ),
          SizedBox(
            width: width / 50,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 60,
                ),
                Text(
                  txt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 54),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  txt2,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Gilroy Medium',
                      fontSize: height / 55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
