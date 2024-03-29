import 'package:flutter/material.dart';
import 'package:gobank/login/minkycpage.dart';

import 'package:gobank/login/phone.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gobank/login/auth_ctrl.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home.dart';
import '../utils/colornotifire.dart';
import '../utils/media.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  late ColorNotifire notifire;
  final authCtrl = Get.find<AuthCtrl>();
  final TextEditingController _pinController = TextEditingController();
  String otp = "";
 // FirebaseAuth auth=FirebaseAuth.instance;
  // final FirebaseAuth auth = authCtrl.auth;
  void verifyFun() async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: MyPhone.verify,
      smsCode: otp,
    );

    final FirebaseAuth auth = authCtrl.auth;
    await auth.signInWithCredential(credential);

    saveVerificationStatus(true);
    bool userExist = await searchForMobileNumber();

    Fluttertoast.showToast(
      msg: 'OTP Verified',
      backgroundColor: Colors.grey,
    );

    Future.delayed(Duration(seconds: 1), () {
      // if (userExist) {
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const Home()),
      //     (route) => false,
      //   );
      // } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const minkycpage()),
        );
     // }
    });
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Wrong OTP',
      backgroundColor: Colors.grey,
    );
     // Retry verification
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Wrong OTP'),
          content: const Text('Please enter the correct OTP.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () {
               
                 Navigator.of(context).pop();
                  setState(() {
                  otp = "";
                  _pinController.clear();
                });
              },
            ),
          ],
        );
      },
    );
    
  }
}


  Future<bool> searchForMobileNumber() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('mobileNo', isEqualTo: authCtrl.auth.currentUser!.phoneNumber)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false; // Target mobile number not found
    }
  }
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
    // final defaultPinTheme = PinTheme(
    //   width: 56,
    //   height: 56,
    //   textStyle: TextStyle(
    //       fontSize: 20,
    //       color: Color.fromRGBO(30, 60, 87, 1),
    //       fontWeight: FontWeight.w600),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    // );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );

    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );
    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhone(),));
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              // PinPut(
              //   fieldsCount: 6,
              //   // defaultPinTheme: defaultPinTheme,
              //   // focusedPinTheme: focusedPinTheme,
              //   // submittedPinTheme: submittedPinTheme,

              //   // showCursor: true,
              //    inputDecoration: InputDecoration(border: OutlineInputBorder()),
              //   onSubmit: (pin) => otp = pin,
              // ),
              PinPut(
                controller: _pinController,
                fieldsCount: 6,
                inputDecoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    otp = value; // Update the otp variable
                  });
                },
                onSubmit: (pin) {
                  setState(() {
                    otp = pin; // Update the otp variable
                  });
                  verifyFun();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: verifyFun,
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyPhone()),
                        );
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: 
           Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
             child: Container( 
              alignment: Alignment.center,
             height:60,
             child: SizedBox(
              child: Column(
                children: [
                  Text("By tapping on Create Account, you agree to the",
                  style: TextStyle(
                            color: notifire.getdarkgreycolor,
                            fontSize: 15,
                            fontFamily: 'Gilroy Medium'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Terms of Service",
                      
                       style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: 15,
                            fontFamily: 'Gilroy Medium',
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            ),
                      ),
                      Text(" & ",
                       style: TextStyle(
                            color: notifire.getdarkgreycolor,
                            fontSize: 15,
                            fontFamily: 'Gilroy Medium'),
                      ),
                      Text("Privacy Policy",
                       style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: 15,
                            fontFamily: 'Gilroy Medium',
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            ),
                      )
                    ],
                  )
                ],
              ),
              )
             ),
           ),
    );
  }
}
