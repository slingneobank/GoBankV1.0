import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

import '../utils/button.dart';

class VerificationDone extends StatefulWidget {
  const VerificationDone({Key? key}) : super(key: key);

  @override
  State<VerificationDone> createState() => _VerificationDoneState();
}

class _VerificationDoneState extends State<VerificationDone> {
  late ColorNotifire notifire;

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
                SizedBox(height: height / 5.5),
                Center(
                    child: Image.asset("images/verificationdone.png",
                        height: height / 3)),
                Text(
                  CustomStrings.verificationdone,
                  style: TextStyle(
                      fontSize: height / 30,
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold'),
                ),
                SizedBox(height: height / 50),
                Text(
                  CustomStrings.theaacountbeen,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height / 55,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkgreycolor),
                ),
                SizedBox(height: height / 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  child: Custombutton.button(
                      notifire.getbluecolor, CustomStrings.done, width / 1.1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
