import 'package:flutter/material.dart';
import 'package:gobank/home/request/requestpayment.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colornotifire.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
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

  List nametxt = [
    CustomStrings.tiana,
    CustomStrings.kaiya,
    CustomStrings.desirae,
    CustomStrings.emery,
    CustomStrings.ruben,
    CustomStrings.roger,
    CustomStrings.jaydon,
  ];

  List imgtxt = [
    "images/man4.png",
    "images/man5.png",
    "images/man6.png",
    "images/man7.png",
    "images/man4.png",
    "images/man5.png",
    "images/man6.png",
  ];

  bool selectedindex = false;
  bool selectedindex1 = false;
  bool selectedindex2 = false;
  bool selectedindex3 = false;
  bool selectedindex4 = false;
  bool selectedindex5 = false;
  bool selectedindex6 = false;

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
            Container(
              height: height / 1.1,
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: nametxt.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RequestPayment(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              height: height / 15,
                              width: width / 7,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle),
                              child: Image.asset(
                                imgtxt[index],
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nametxt[index],
                                  style: TextStyle(
                                      fontSize: height / 45,
                                      color: notifire.getdarkscolor,
                                      fontFamily: 'Gilroy Bold'),
                                ),
                                SizedBox(
                                  height: height / 200,
                                ),
                                Text(
                                  CustomStrings.bca1,
                                  style: TextStyle(
                                      fontSize: height / 55,
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy Medium'),
                                ),
                              ],
                            ),
                            const Spacer(),
                            index == 0
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedindex = !selectedindex;
                                      });
                                    },
                                    child: selectedindex
                                        ? Image.asset(
                                            "images/fillstar.png",
                                            height: height / 35,
                                          )
                                        : Image.asset(
                                            "images/favorite.png",
                                            height: height / 35,
                                            color: notifire.getdarkscolor,
                                          ),
                                  )
                                : index == 1
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedindex1 = !selectedindex1;
                                          });
                                        },
                                        child: selectedindex1
                                            ? Image.asset(
                                                "images/fillstar.png",
                                                height: height / 35,
                                              )
                                            : Image.asset(
                                                "images/favorite.png",
                                                height: height / 35,
                                                color: notifire.getdarkscolor,
                                              ),
                                      )
                                    : index == 2
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedindex2 =
                                                    !selectedindex2;
                                              });
                                            },
                                            child: selectedindex2
                                                ? Image.asset(
                                                    "images/fillstar.png",
                                                    height: height / 35,
                                                  )
                                                : Image.asset(
                                                    "images/favorite.png",
                                                    height: height / 35,
                                                    color:
                                                        notifire.getdarkscolor,
                                                  ),
                                          )
                                        : index == 3
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedindex3 =
                                                        !selectedindex3;
                                                  });
                                                },
                                                child: selectedindex3
                                                    ? Image.asset(
                                                        "images/fillstar.png",
                                                        height: height / 35,
                                                      )
                                                    : Image.asset(
                                                        "images/favorite.png",
                                                        height: height / 35,
                                                        color: notifire
                                                            .getdarkscolor,
                                                      ),
                                              )
                                            : index == 4
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedindex4 =
                                                            !selectedindex4;
                                                      });
                                                    },
                                                    child: selectedindex4
                                                        ? Image.asset(
                                                            "images/fillstar.png",
                                                            height: height / 35,
                                                          )
                                                        : Image.asset(
                                                            "images/favorite.png",
                                                            height: height / 35,
                                                            color: notifire
                                                                .getdarkscolor,
                                                          ),
                                                  )
                                                : index == 5
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedindex5 =
                                                                !selectedindex5;
                                                          });
                                                        },
                                                        child: selectedindex5
                                                            ? Image.asset(
                                                                "images/fillstar.png",
                                                                height:
                                                                    height / 35,
                                                              )
                                                            : Image.asset(
                                                                "images/favorite.png",
                                                                height:
                                                                    height / 35,
                                                                color: notifire
                                                                    .getdarkscolor,
                                                              ),
                                                      )
                                                    : index == 6
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedindex6 =
                                                                    !selectedindex6;
                                                              });
                                                            },
                                                            child:
                                                                selectedindex6
                                                                    ? Image
                                                                        .asset(
                                                                        "images/fillstar.png",
                                                                        height:
                                                                            height /
                                                                                35,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "images/favorite.png",
                                                                        color: notifire
                                                                            .getdarkscolor,
                                                                        height:
                                                                            height /
                                                                                35,
                                                                      ),
                                                          )
                                                        : Image.asset(
                                                            "images/favorite.png",
                                                            height: height / 35,
                                                          ),
                            SizedBox(
                              width: width / 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
