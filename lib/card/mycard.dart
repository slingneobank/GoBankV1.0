import 'package:flutter/material.dart';
import 'package:gobank/card/createxcard.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
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

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Stack(
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
                      Image.asset(
                        "images/logos.png",
                        height: height / 25,fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: width / 30,
                      ),
                      Text(
                        CustomStrings.mycard,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 40,
                            fontFamily: 'Gilroy Bold'),
                      ),
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
                        CustomStrings.mcard,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy Bold'),
                      ),
                      SizedBox(
                        width: width / 40,
                      ),
                      Container(
                        height: height / 40,
                        width: width / 8,
                        decoration: BoxDecoration(
                          color: notifire.getbluecolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            CustomStrings.actives,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height / 70,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CustomStrings.balance,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: 'Gilroy Bold'),
                      ),
                      SizedBox(
                        width: width / 100,
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: notifire.getdarkscolor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height / 50),
                  child: Image.asset("images/visa1.png"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      Text(
                        CustomStrings.ecard,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy Bold'),
                      ),
                      SizedBox(
                        width: width / 40,
                      ),
                      Container(
                        height: height / 40,
                        width: width / 8,
                        decoration: BoxDecoration(
                          color: notifire.getbluecolor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            CustomStrings.actives,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: height / 70,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CustomStrings.balance,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: 'Gilroy Bold'),
                      ),
                      SizedBox(
                        width: width / 100,
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: notifire.getdarkscolor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height / 50),
                  child: Image.asset("images/visa2.png"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      Text(
                        CustomStrings.xcard,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy Bold'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Createxcard(),),);
                    },
                    child: Container(
                      height: height / 18,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getbluecolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          CustomStrings.addxcard,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy Bold',
                            fontSize: height / 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
