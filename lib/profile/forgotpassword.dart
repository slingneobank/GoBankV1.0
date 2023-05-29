import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/textfeilds.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: notifire.getdarkscolor,
                      ),
                    ),
                    SizedBox(
                      width: width / 4,
                    ),
                    Text(
                      CustomStrings.forgotpasswords,
                      style: TextStyle(
                          fontSize: height / 40,
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy Bold'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 20,
                ),
                Image.asset(
                  "images/forgotp.png",
                  height: height / 7,
                ),
                SizedBox(
                  height: height / 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    Text(
                      CustomStrings.resetyourpassword,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: height / 40,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 100,),
                Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    Text(
                      CustomStrings.linkemail,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: height / 60,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 40,),
                Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    Text(
                      CustomStrings.email,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: height / 50,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 60,),
                Customtextfilds.textField(
                  notifire.getdarkscolor,
                  notifire.getdarkgreycolor,
                  notifire.getbluecolor,
                  "images/email.png",
                  CustomStrings.emailhint,notifire.getdarkwhitecolor
                ),
                SizedBox(height: height / 2.5,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 17,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getbluecolor,
                        borderRadius: const BorderRadius.all(Radius.circular(30),),
                      ),
                      child: Center(
                        child: Text(CustomStrings.sendemail,style: TextStyle(color: Colors.white,fontFamily: 'Gilroy Medium',
                        fontSize: height / 50
                        ),),
                      ),
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
