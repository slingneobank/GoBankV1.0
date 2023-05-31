import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gobank/login/setupprofile.dart';
import 'package:gobank/login/verify.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/button.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';
import '../utils/string.dart';
import '../utils/textfeilds.dart';
import 'auth_ctrl.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late ColorNotifire notifire;
  final authCtrl = Get.find<AuthCtrl>();
  bool loading = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
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
                    "images/background.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 20,
                    ),
                    Center(
                      child: Text(
                        CustomStrings.register,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: 'Gilroy Bold',
                            fontSize: height / 35),
                      ),
                    ),
                    SizedBox(
                      height: height / 12.2,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            height: height / 1.4,
                            width: width / 1.1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height / 30,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 18,
                                    ),
                                    Text(
                                      CustomStrings.fullname,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 50,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 135,
                                ),
                                Customtextfilds.textField(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/fullname.png",
                                    CustomStrings.fullnamehere,
                                    notifire.getdarkwhitecolor,
                                    controller: authCtrl.fullnameCtrl),
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 18,
                                    ),
                                    Text(
                                      CustomStrings.email,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 70,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 70,
                                ),
                                Customtextfilds.textField(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/email.png",
                                    CustomStrings.emailhint,
                                    notifire.getdarkwhitecolor,
                                    controller: authCtrl.emailCtrl),
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 18,
                                    ),
                                    Text(
                                      "Phone number",
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 70,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 70,
                                ),
                                Customtextfilds.textField(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/mobile.png",
                                    // replace with phone call image file
                                    "Enter Phone Number",
                                    notifire.getdarkwhitecolor,
                                    controller: authCtrl.phoneCtrl),
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 18,
                                    ),
                                    Text(
                                      CustomStrings.password,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 50,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                textfieldss(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/password.png",
                                    CustomStrings.createpassword,
                                    "images/show.png",
                                    controller: authCtrl.passwordCtrl1),
                                SizedBox(
                                  height: height / 35,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width / 18,
                                    ),
                                    Text(
                                      CustomStrings.confirmpassword,
                                      style: TextStyle(
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 50,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 70,
                                ),
                                textfieldss(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/password.png",
                                    CustomStrings.retypepassword,
                                    "images/show.png",
                                    controller: authCtrl.passwordCtrl2),
                                SizedBox(
                                  height: height / 35,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (loading == false) {
                                      if (authCtrl.passwordCtrl2.text ==
                                              authCtrl.passwordCtrl1.text &&
                                          authCtrl.fullnameCtrl.text.trim() !=
                                              "" &&
                                          authCtrl.emailCtrl.text.trim() !=
                                              "" &&
                                          authCtrl.passwordCtrl1.text.trim() !=
                                              "") {
                                        loading = true;
                                        setState(() {});
                                        authCtrl.slingUser.name =
                                            authCtrl.fullnameCtrl.text;
                                        authCtrl.slingUser.email =
                                            authCtrl.emailCtrl.text;

                                        await authCtrl
                                            .createUserWithEmailAndPassword(
                                                authCtrl.emailCtrl.text,
                                                authCtrl.passwordCtrl2.text,
                                                authCtrl.fullnameCtrl.text,
                                                authCtrl.phoneCtrl.text)
                                            .then((value) {
                                          loading = false;
                                          setState(() {});
                                          if (value == false) {
                                            return;
                                          }

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SetupProfile(), //before routed to verify.dart
                                            ),
                                          );
                                        });
                                      } else {
                                        loading = false;
                                        setState(() {});
                                        Fluttertoast.showToast(
                                            msg: "Please check the values");
                                      }
                                    }
                                  },
                                  child: loading
                                      ? Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              color: notifire.getbluecolor,
                                            ),
                                            height: height / 15,
                                            width: width / 5,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.white,
                                            )),
                                          ),
                                        )
                                      : Custombutton.button(
                                          notifire.getbluecolor,
                                          CustomStrings.registeraccount,
                                          width / 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CustomStrings.accounts,
                          style: TextStyle(
                            color: notifire.getdarkgreycolor.withOpacity(0.6),
                            fontSize: height / 50,
                          ),
                        ),
                        SizedBox(
                          width: width / 100,
                        ),
                        Text(
                          CustomStrings.loginhear,
                          style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height / 10,
                    ),
                    Center(
                      child: Image.asset(
                        "images/logos.png",
                        height: height / 8,
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

  Widget textfieldss(textclr, hintclr, borderclr, img, hinttext, img2,
      {controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 18),
      child: Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          controller: controller,
          autofocus: false,
          style: TextStyle(
            fontSize: height / 50,
            color: textclr,
          ),
          decoration: InputDecoration(
            hintText: hinttext,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height / 50, horizontal: height / 70),
              child: Image.asset(
                img2,
                height: height / 50,
              ),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height / 100, horizontal: height / 70),
              child: Image.asset(
                img,
                height: height / 30,
              ),
            ),
            hintStyle: TextStyle(color: hintclr, fontSize: height / 60),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderclr),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
