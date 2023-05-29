import 'package:flutter/material.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class LegalPolicy extends StatefulWidget {
  final String title;
  const LegalPolicy(this.title, {Key? key}) : super(key: key);

  @override
  State<LegalPolicy> createState() => _LegalPolicyState();
}

class _LegalPolicyState extends State<LegalPolicy> {
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
                        widget.title,
                        style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontSize: height / 40,
                          fontFamily: 'Gilroy Bold',
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: height / 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      Text(
                        CustomStrings.terms,
                        style: TextStyle(
                          fontSize: height / 45,
                          fontFamily: 'Gilroy Bold',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height / 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Text(
                    CustomStrings.lorem,
                    style: TextStyle(
                      fontSize: height / 55,
                      color: Colors.grey,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Text(
                    CustomStrings.lorem,
                    style: TextStyle(
                      fontSize: height / 55,
                      color: Colors.grey,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      CustomStrings.changesterms,
                      style: TextStyle(
                        fontSize: height / 45,
                        fontFamily: 'Gilroy Bold',
                      ),
                    )
                  ],
                ),
                SizedBox(height: height / 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Text(
                    CustomStrings.lorem,
                    style: TextStyle(
                      fontSize: height / 55,
                      color: Colors.grey,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Text(
                    CustomStrings.lorem,
                    style: TextStyle(
                      fontSize: height / 55,
                      color: Colors.grey,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
