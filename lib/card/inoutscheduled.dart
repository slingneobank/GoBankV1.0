import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class InOutScheduled extends StatefulWidget {
  const InOutScheduled({Key? key}) : super(key: key);

  @override
  State<InOutScheduled> createState() => _InOutScheduledState();
}

class _InOutScheduledState extends State<InOutScheduled> {
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
  List paymentname = [
    CustomStrings.mcdonaldsorders,
    CustomStrings.airbnb,
    CustomStrings.darron,
    CustomStrings.netflixsubscription,
    CustomStrings.hunnah,
    CustomStrings.aileen
  ];
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
  List colorname = [
    const Color(0xff6C56F9).withOpacity(0.4),
    const Color(0xff6C56F9).withOpacity(0.4),
    const Color(0xff6C56F9),
    const Color(0xff6C56F9),
    const Color(0xff6C56F9),
    const Color(0xff6C56F9),
  ];
  List colortxt = [
    const Color(0xff6C56F9),
    const Color(0xff6C56F9),
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  List historyname = [
    CustomStrings.expense,
    CustomStrings.income,
    CustomStrings.income,
    CustomStrings.expense,
    CustomStrings.income,
    CustomStrings.expense
  ];

  List paymenttypename = [
    CustomStrings.scheduled,
    CustomStrings.scheduled,
    CustomStrings.completed,
    CustomStrings.completed,
    CustomStrings.completed,
    CustomStrings.completed
  ];
  List amount = [
    "\$125",
    "\$90",
    "\$157",
    "\$162",
    "\$110",
    "\$129",
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
                  CustomStrings.showingscheduled,
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
                            child: Image.asset(img[index]),
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
                                amount[index],
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: height / 50,
                                    fontFamily: 'Gilroy Bold'),
                              ),
                              SizedBox(
                                height: height / 150,
                              ),
                              Container(
                                height: height / 42,
                                width: width / 6.2,
                                decoration: BoxDecoration(
                                  color: colorname[index],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    paymenttypename[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: colortxt[index],
                                        fontSize: height / 76,
                                        fontFamily: 'Gilroy Bold'),
                                  ),
                                ),
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
