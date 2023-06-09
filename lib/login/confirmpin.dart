import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:gobank/verification/verificationdone.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../utils/button.dart';
import 'auth_ctrl.dart';

class ConfirmPin extends StatefulWidget {
  const ConfirmPin({Key? key}) : super(key: key);

  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> {
  late ColorNotifire notifire;
  final authCtrl = Get.find<AuthCtrl>();

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
              color: notifire.getprimerycolor,
              child: Image.asset(
                "images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(height: height / 20),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: notifire.getdarkscolor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 20),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      CustomStrings.confirmyourpin,
                      style: TextStyle(
                        fontFamily: 'Gilroy Bold',
                        color: notifire.getdarkscolor,
                        fontSize: height / 30,
                      ),
                    ),
                    SizedBox(width: width / 80),
                  ],
                ),
                SizedBox(height: height / 80),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      CustomStrings.youwilluse,
                      style: TextStyle(
                        color: notifire.getdarkgreycolor,
                        fontFamily: 'Gilroy Medium',
                        fontSize: height / 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 30),
                animatedBorders(),
                SizedBox(height: height / 1.8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationDone(),
                      ),
                    );
                  },
                  child: Custombutton.button(notifire.getbluecolor,
                      CustomStrings.savepin, width / 1.1),
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
        controller: authCtrl.pin2Ctrl,
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
          border: Border.all(color: notifire.getbluecolor),
          color: notifire.gettabwhitecolor,
          borderRadius: BorderRadius.circular(10.0),
        ).copyWith(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
