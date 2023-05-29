import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({Key? key}) : super(key: key);

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
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

  List todayimg = ["images/history1.png","images/history2.png"];
  List todaytxt = [CustomStrings.tiana,CustomStrings.figma];
  List todaydiscription = ["BCA • 2468 3545 ****",CustomStrings.subscription];
  List todayamount = ["\$154,42","\$433,00"];

  List yesterdayimg = ["images/history1.png","images/history2.png","images/history1.png"];
  List yesterdaytxt = [CustomStrings.tiana,CustomStrings.figma,CustomStrings.tiana,];
  List yesterdaydiscription = ["BCA • 2468 3545 ****",CustomStrings.subscription,"BCA • 2468 3545 ****",];
  List yesterdayamount = ["\$433,42","\$433,00","\$433,00"];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Image.asset(
                    "images/background.png",
                    fit: BoxFit.cover,
                  ),
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
                          SizedBox(
                            width: width / 30,
                          ),
                          Text(
                            CustomStrings.recenttransaction,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy Bold',
                                fontSize: height / 40),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.more_horiz,
                            color: notifire.getdarkscolor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Text(
                            CustomStrings.today,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy Bold',
                                fontSize: height / 45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: height / 4.9,
                      child: ListView.builder(
                        itemCount: todayimg.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: height / 400,),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 13,
                                    width: width / 6.5,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(todayimg[index]),
                                  ),
                                  SizedBox(
                                    width: width / 35,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                       todaytxt[index],
                                        style: TextStyle(
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 48,
                                            fontFamily: 'Gilroy Bold'),
                                      ),
                                      SizedBox(
                                        height: height / 150,
                                      ),
                                      Text(
                                        todaydiscription[index],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: height / 55,
                                            fontFamily: 'Gilroy Medium'),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    todayamount[index],
                                    style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,
                                        fontFamily: 'Gilroy Bold'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 200,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width / 20),
                              child: Divider(
                                color: Colors.grey.withOpacity(0.4),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Text(
                            CustomStrings.yesterday,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy Bold',
                                fontSize: height / 45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Container(
                      color: Colors.transparent,
                      height: height / 3.2,
                      child: ListView.builder(
                        itemCount: yesterdayimg.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: height / 400,),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width / 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 13,
                                    width: width / 6.5,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(yesterdayimg[index]),
                                  ),
                                  SizedBox(
                                    width: width / 35,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        yesterdaytxt[index],
                                        style: TextStyle(
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 48,
                                            fontFamily: 'Gilroy Bold'),
                                      ),
                                      SizedBox(
                                        height: height / 150,
                                      ),
                                      Text(
                                        yesterdaydiscription[index],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: height / 55,
                                            fontFamily: 'Gilroy Medium'),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    yesterdayamount[index],
                                    style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,
                                        fontFamily: 'Gilroy Bold'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 200,
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width / 20),
                              child: Divider(
                                color: Colors.grey.withOpacity(0.4),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
