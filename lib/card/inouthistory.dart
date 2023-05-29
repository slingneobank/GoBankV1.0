import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class InOutHistory extends StatefulWidget {
  const InOutHistory({Key? key}) : super(key: key);

  @override
  State<InOutHistory> createState() => _InOutHistoryState();
}

class _InOutHistoryState extends State<InOutHistory> {
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

  List img = [
    "images/mcd.png",
    "images/man6.png",
    "images/man5.png",
    "images/netflix.png",
    "images/man3.png",
    "images/man4.png"
  ];
  List iconname = [
    Icons.arrow_circle_up,
    Icons.arrow_circle_down,
    Icons.arrow_circle_down,
    Icons.arrow_circle_up,
    Icons.arrow_circle_down,
    Icons.arrow_circle_up,
  ];
  List paymentamount = [
    "\$25",
    "\$1225",
    "\$250",
    "\$32",
    "\$60",
    "\$80",
  ];
  List colorname = [
    Colors.red,
    const Color(0xff6C56F9),
    const Color(0xff6C56F9),
    Colors.red,
    const Color(0xff6C56F9),
    Colors.red
  ];
  List historyname = [
    CustomStrings.expense,
    CustomStrings.income,
    CustomStrings.income,
    CustomStrings.expense,
    CustomStrings.income,
    CustomStrings.expense
  ];
  List paymentname = [
    CustomStrings.mcdonaldsorders,
    CustomStrings.airbnb,
    CustomStrings.darron,
    CustomStrings.netflixsubscription,
    CustomStrings.hunnah,
    CustomStrings.aileen
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 50,
            ),
            Row(
              children: [
                Text(
                  CustomStrings.showinghistory,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 50),
                ),
                const Spacer(),
                Icon(
                  Icons.cloud_download_rounded,
                  color: notifire.getbluecolor,
                ),
                SizedBox(
                  width: width / 90,
                ),
                Text(
                  CustomStrings.download,
                  style: TextStyle(
                      color: notifire.getbluecolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 50),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              height: height / 1.29,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView.builder(
                itemCount: img.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: height / 60),
                  child: Container(
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: notifire.gettabwhitecolor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 80),
                      child: Row(
                        children: [
                          Container(
                            height: height / 16,
                            width: width / 9,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(img[index],),
                          ),
                          SizedBox(
                            width: width / 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                paymentname[index],
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy Bold'),
                              ),
                              SizedBox(
                                height: height / 150,
                              ),
                              Text(
                                CustomStrings.historydate,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: height / 60,
                                    fontFamily: 'Gilroy Medium'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                paymentamount[index],
                                style: TextStyle(
                                    color: colorname[index],
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy Bold'),
                              ),
                              SizedBox(
                                height: height / 150,
                              ),
                              Row(
                                children: [
                                  Icon(iconname[index],
                                      color: colorname[index],
                                      size: height / 40),
                                  SizedBox(
                                    width: width / 100,
                                  ),
                                  Text(
                                    historyname[index],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: height / 60,
                                        fontFamily: 'Gilroy Medium'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
