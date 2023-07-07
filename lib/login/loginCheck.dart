import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/login/auth_ctrl.dart';
import 'package:gobank/login/phone.dart';
import 'package:gobank/onbonding.dart';
// import 'package:gobank/login/register.dart';
// import 'package:gobank/login/verify_pin.dart';
// import 'package:gobank/utils/button.dart';
// import 'package:gobank/utils/media.dart';
// import 'package:gobank/utils/string.dart';
// import 'package:gobank/utils/textfeilds.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck extends StatelessWidget {
  // ignore: use_key_in_widget_constructors

  final authCtrl = Get.find<AuthCtrl>();

  LoginCheck({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authCtrl.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const MyPhone();
          }
        },
      ),
    );
  }
}
