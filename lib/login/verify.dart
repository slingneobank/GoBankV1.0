import 'package:flutter/material.dart';
import 'package:gobank/login/setupprofile.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/button.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
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
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/img1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 20,
                    ),
                    Center(
                      child: Image.asset(
                        "images/verifiy.png",
                        height: height / 5,
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                      CustomStrings.verification,
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontSize: height / 40,
                          fontFamily: 'Gilroy Bold'),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Text(
                      CustomStrings.verification1,
                      style: TextStyle(
                          color: notifire.getdarkgreycolor,
                          fontSize: height / 65,
                          fontFamily: 'Gilroy Medium'),
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Text(
                      CustomStrings.verification2,
                      style: TextStyle(
                          color: notifire.getdarkgreycolor,
                          fontSize: height / 65,
                          fontFamily: 'Gilroy Medium'),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    animatedBorders(),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CustomStrings.code,
                          style: TextStyle(
                            color: notifire.getdarkgreycolor.withOpacity(0.6),
                            fontSize: height / 60,
                          ),
                        ),
                        SizedBox(
                          width: width / 100,
                        ),
                        Text(
                          CustomStrings.resendcode,
                          style: TextStyle(
                            color: notifire.getbluecolor,
                            fontSize: height / 60,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetupProfile(),
                          ),
                        );
                      },
                      child: Custombutton.button(notifire.getbluecolor,
                          CustomStrings.verityme, width / 2),
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

  Widget animatedBorders() {
    return Container(
      color: notifire.getprimerycolor,
      height: height / 14,
      width: width / 1.2,
      child: PinPut(
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Gilroy Bold",
            fontSize: height / 40),
        fieldsCount: 4,
        eachFieldWidth: width / 6.5,
        withCursor: false,
        submittedFieldDecoration: BoxDecoration(
                color: notifire.gettabwhitecolor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor))
            .copyWith(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor)),
        selectedFieldDecoration: BoxDecoration(
            color: notifire.gettabwhitecolor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: notifire.getbluecolor)),
        followingFieldDecoration: BoxDecoration(
                color: notifire.gettabwhitecolor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor))
            .copyWith(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor)),
      ),
    );
  }
}
