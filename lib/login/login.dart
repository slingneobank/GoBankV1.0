import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gobank/login/auth_ctrl.dart';
import 'package:gobank/login/register.dart';
import 'package:gobank/login/verify.dart';
import 'package:gobank/login/verify_pin.dart';
import 'package:gobank/profile/forgotpassword.dart';
import 'package:gobank/utils/button.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:gobank/utils/textfeilds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ColorNotifire notifire;
  bool loading = false;
  final authCtrl = Get.find<AuthCtrl>();

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
                        CustomStrings.login,
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
                            height: height / 1.2,
                            width: width / 1.1,
                            decoration: BoxDecoration(
                              color: notifire.gettabwhitecolor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height / 15,
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
                                        fontSize: height / 50,
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
                                    inputType: TextInputType.emailAddress,
                                    controller: authCtrl.emailCtrl3),
                                SizedBox(
                                  height: height / 35,
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
                                SizedBox(
                                  height: height / 70,
                                ),
                                Customtextfilds.textField(
                                    notifire.getdarkscolor,
                                    notifire.getdarkgreycolor,
                                    notifire.getbluecolor,
                                    "images/password.png",
                                    CustomStrings.passwordhint,
                                    notifire.getdarkwhitecolor,
                                    controller: authCtrl.passwordCtrl3),
                                SizedBox(
                                  height: height / 35,
                                ),
                                // Row(
                                //   children: [
                                //     const Spacer(),
                                //     GestureDetector(
                                //       onTap: () {
                                //         Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const ForgotPassword(),
                                //           ),
                                //         );
                                //       },
                                //       child: Container(
                                //         height: height / 40,
                                //         color: Colors.transparent,
                                //         child: Text(
                                //           CustomStrings.forgotpassword,
                                //           style: TextStyle(
                                //               color: notifire.getdarkscolor,
                                //               fontSize: height / 60,
                                //               fontFamily: 'Gilroy Medium'),
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: width / 18,
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: height / 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (authCtrl.emailCtrl3.text.isNotEmpty &&
                                        authCtrl
                                            .passwordCtrl3.text.isNotEmpty) {
                                      loading = true;
                                      setState(() {});
                                      await authCtrl
                                          .signInWithEmailAndPassword(
                                              authCtrl.emailCtrl3.text,
                                              authCtrl.passwordCtrl3.text)
                                          .then((value) {
                                        loading = false;
                                        setState(() {});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const VerifyPin(),
                                          ),
                                        );
                                      });
                                    } else {
                                      loading = false;
                                      setState(() {});
                                      Fluttertoast.showToast(
                                          msg: "Please check the values");
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
                                          CustomStrings.login,
                                          width / 2),
                                ),
                                SizedBox(
                                  height: height / 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: height / 700,
                                        width: width / 3,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "or",
                                        style: TextStyle(
                                          color: notifire.getdarkgreycolor,
                                          fontSize: height / 50,
                                        ),
                                      ),
                                      Container(
                                        height: height / 700,
                                        width: width / 3,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height / 20,
                                ),
                                // Row(
                                //   children: [
                                //     const Spacer(),
                                //     Container(
                                //       height: height / 10,
                                //       width: width / 5.1,
                                //       decoration: BoxDecoration(
                                //         color: notifire.getprimerycolor,
                                //         borderRadius: BorderRadius.circular(19),
                                //         boxShadow: [
                                //           BoxShadow(
                                //             color: const Color(0xff6C56F9)
                                //                 .withOpacity(0.11),
                                //             blurRadius: 10.0,
                                //           ),
                                //         ],
                                //       ),
                                //       child: Center(
                                //         child: Image.asset(
                                //           "images/facebook.png",
                                //           height: height / 20,
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: width / 12,
                                //     ),
                                //     Container(
                                //       height: height / 10,
                                //       width: width / 5.1,
                                //       decoration: BoxDecoration(
                                //         color: notifire.getprimerycolor,
                                //         borderRadius: BorderRadius.circular(19),
                                //         boxShadow: [
                                //           BoxShadow(
                                //             color: const Color(0xff6C56F9)
                                //                 .withOpacity(0.11),
                                //             blurRadius: 10.0,
                                //           ),
                                //         ],
                                //       ),
                                //       child: Center(
                                //         child: Image.asset(
                                //           "images/google.png",
                                //           height: height / 20,
                                //         ),
                                //       ),
                                //     ),
                                //     const Spacer(),
                                //   ],
                                // ),
                                SizedBox(
                                  height: height / 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CustomStrings.account,
                                      style: TextStyle(
                                        color: notifire.getdarkgreycolor
                                            .withOpacity(0.6),
                                        fontSize: height / 50,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 100,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Register(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        CustomStrings.registerhere,
                                        style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        height: height / 7,
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
