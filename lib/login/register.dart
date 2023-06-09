import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../utils/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('users').push();
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

  String dropdownvalue = '01';
  String monthvalue = '01';
  String yearvalue = '2018';
  String gendervalue = CustomStrings.male;
  var genderitems = [
    CustomStrings.male,
    CustomStrings.female,
  ];

  @override
  void initState() {
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
                                  height: height / 100,
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
                                  height: height / 60,
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
                                SizedBox(height: height / 50),
                                Row(
                                  children: [
                                    SizedBox(width: width / 20),
                                    Text(
                                      CustomStrings.dateofbirth,
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50,
                                          fontFamily: 'Gilroy Bold'),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 80),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: height / 17,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                        color: notifire.gettabwhitecolor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      child: DropdownButton(
                                        underline: const SizedBox(),
                                        // Initial Value
                                        value: dropdownvalue,

                                        // Down Arrow Icon
                                        icon: Row(
                                          children: [
                                            SizedBox(width: width / 40),
                                            Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: notifire.getdarkscolor,
                                            ),
                                          ],
                                        ),

                                        // Array list of items
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Row(
                                              children: [
                                                SizedBox(width: width / 50),
                                                Text(
                                                  items,
                                                  style: TextStyle(
                                                      fontSize: height / 60),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: height / 17,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                        color: notifire.gettabwhitecolor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      child: DropdownButton(
                                        underline: const SizedBox(),
                                        // Initial Value
                                        value: monthvalue,

                                        // Down Arrow Icon
                                        icon: Row(
                                          children: [
                                            SizedBox(width: width / 40),
                                            Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: notifire.getdarkscolor,
                                            ),
                                          ],
                                        ),

                                        // Array list of items
                                        items:
                                            monthitems.map((String monthitems) {
                                          return DropdownMenuItem(
                                            value: monthitems,
                                            child: Row(
                                              children: [
                                                SizedBox(width: width / 50),
                                                Text(
                                                  monthitems,
                                                  style: TextStyle(
                                                      fontSize: height / 60),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            monthvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: height / 17,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                        color: notifire.gettabwhitecolor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      child: DropdownButton(
                                        underline: const SizedBox(),
                                        // Initial Value
                                        value: yearvalue,

                                        // Down Arrow Icon
                                        icon: Row(
                                          children: [
                                            SizedBox(width: width / 40),
                                            Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: notifire.getdarkscolor,
                                            ),
                                          ],
                                        ),

                                        // Array list of items
                                        items:
                                            yearitems.map((String yearitems) {
                                          return DropdownMenuItem(
                                            value: yearitems,
                                            child: Row(
                                              children: [
                                                SizedBox(width: width / 50),
                                                Text(
                                                  yearitems,
                                                  style: TextStyle(
                                                      fontSize: height / 60),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            yearvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height / 50),
                                Row(
                                  children: [
                                    SizedBox(width: width / 20),
                                    Text(
                                      CustomStrings.gender,
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50,
                                          fontFamily: 'Gilroy Bold'),
                                    )
                                  ],
                                ),
                                SizedBox(height: height / 80),
                                Container(
                                  height: height / 17,
                                  width: width / 1.4,
                                  decoration: BoxDecoration(
                                    color: notifire.gettabwhitecolor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    // Initial Value
                                    value: gendervalue,

                                    // Down Arrow Icon
                                    icon: Row(
                                      children: [
                                        SizedBox(width: width / 2),
                                        Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: notifire.getdarkscolor,
                                        ),
                                      ],
                                    ),
                                    items:
                                        genderitems.map((String genderitems) {
                                      return DropdownMenuItem(
                                        value: genderitems,
                                        child: Row(
                                          children: [
                                            SizedBox(width: width / 50),
                                            Text(
                                              genderitems,
                                              style: TextStyle(
                                                  fontSize: height / 60),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        gendervalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: height / 25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (loading == false) {
                                      if (
                                          // authCtrl.passwordCtrl2.text ==
                                          //         authCtrl.passwordCtrl1.text &&
                                          authCtrl.fullnameCtrl.text.trim() !=
                                                  "" &&
                                              authCtrl.emailCtrl.text.trim() !=
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
                                            .then((value) async {
                                          loading = false;
                                          setState(() {});
                                          if (value == false) {
                                            return;
                                          }
                                          // Store user data in Firebase
                                          String mobileNo = authCtrl.auth
                                                  .currentUser!.phoneNumber ??
                                              "+910000000000";
                                          await firestore
                                              .collection('users')
                                              .doc(authCtrl.emailCtrl.text)
                                              .set({
                                            'mobileNo': mobileNo,
                                            'name': authCtrl.fullnameCtrl.text,
                                            'email': authCtrl.emailCtrl.text,
                                            'dob': authCtrl.dobctrl.text,
                                            'gender': authCtrl.genderCtrl.text,
                                          });
                                          // Store user data in Firebase Realtime Database
                                          await authCtrl
                                              .createUserAndSaveData();
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home(), //before routed to verifyOTP.dart
                                              ),
                                              (route) => false);
                                          // Navigator.push(
                                          //   context,
                                          //   ,
                                          // );
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
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.white,
                                            )),
                                          ),
                                        )
                                      : Custombutton.button(
                                          notifire.getbluecolor,
                                          "Continue",
                                          width / 2),
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
                        "images/slingneo logo.png",
                        height: height / 9,
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
