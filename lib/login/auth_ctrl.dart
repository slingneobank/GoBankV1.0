
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/constants.dart';
import 'package:gobank/models/sling_user.dart';

class AuthCtrl extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  Dio dio = Dio();

  SlingUser slingUser = SlingUser(activated: false, kycDone: false);
  User? user;
  TextEditingController fullnameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl1 = TextEditingController();
  TextEditingController emailCtrl3 = TextEditingController();
  TextEditingController passwordCtrl3 = TextEditingController();
  TextEditingController passwordCtrl2 = TextEditingController();
  TextEditingController mblCtrl = TextEditingController();
  TextEditingController pin1Ctrl = TextEditingController();
  TextEditingController pin2Ctrl = TextEditingController();
  String pineToken = "";

  Future createUserWithEmailAndPassword(
      emailAddress, password, name, number) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then((credential) async {
        await credential.user?.updateDisplayName(name);
        await credential.user?.updatePhoneNumber(number);
        user = credential.user;
// await credential.user?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signInWithEmailAndPassword(emailAddress, password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  Future createUser() async {
    try {
      slingUser.name = fullnameCtrl.text;
      slingUser.mobile = mblCtrl.text;
      slingUser.name = fullnameCtrl.text;
      debugPrint(slingUser.toJson().toString());
      await database
          .ref()
          .child("users")
          .child(slingUser.mobile.toString())
          .set(slingUser.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  signOut() async {
    await auth.signOut();
  }

  //KYC RELATED FUNCTIONS

  Future genTokenApi() async {
    var url = "$baseUrl/auth/V2/generate/token";
    debugPrint(url);
    try {
      var response = await dio.get(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-PinePerks-UserName":
                "38LEQQI1V0s6z49cAVYCuA==", //sandbox username
            // "X-PinePerks-Token": pineToken
          }));
      if (response.statusCode == 200) {
        pineToken = response.data["accessToken"];
        debugPrint(response.data.toString());
      } else {
        debugPrint("Gen token Api status not 200");
      }
    } catch (e) {
      debugPrint("Gen token Api error" + e.toString());
      return false;
    }
  }

  initMinKyc() async {
    var url = "$baseUrl/customer/profile/V2/initiate/minKyc";
    debugPrint(url);
    try {
      var response = await dio.post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-PinePerks-UserName":
                "38LEQQI1V0s6z49cAVYCuA==", //sandbox username
            "X-PinePerks-Token": pineToken
          }),
          queryParameters: {
            "kycRequestDetail": [
              {
                "customerName": slingUser.name,
                "mobileNumber": slingUser.mobile,
                "email": slingUser.email
              }
            ]
          });
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
      } else {
        debugPrint("Error");
      }
    } catch (e) {
      debugPrint("error" + e.toString());
    }
  }

  genMinKyc() async {
    var url = "$baseUrl/customer/profile/V1/minKyc/generateRequest";
    debugPrint(url);
    try {
      var response = await dio.post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-PinePerks-UserName":
                "38LEQQI1V0s6z49cAVYCuA==", //sandbox username
            "X-PinePerks-Token": pineToken
          }),
          queryParameters: {
            "customerName": slingUser.name,
            "mobileNumber": slingUser.mobile,
            "email": slingUser.email
          });
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
      } else {
        debugPrint("Error");
      }
    } catch (e) {
      debugPrint("error" + e.toString());
    }
  }

  validateKycOtp(minKycUniqueId, otp) async {
    var url = "$baseUrl/customer/profile/V1/minKyc/validate/otp";
    debugPrint(url);
    try {
      var response = await dio.post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-PinePerks-UserName":
                "38LEQQI1V0s6z49cAVYCuA==", //sandbox username
            "X-PinePerks-Token": pineToken
          }),
          queryParameters: {"minKycUniqueId": minKycUniqueId, "otp": otp});
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
      } else {
        debugPrint("Error");
      }
    } catch (e) {
      debugPrint("error" + e.toString());
    }
  }

  verifyMinKycDoc(minKycUniqueId) async {
    var url = "$baseUrl/customer/profile/V1/minKyc/verify/document";
    debugPrint(url);
    try {
      var response = await dio.post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "X-PinePerks-UserName":
                "38LEQQI1V0s6z49cAVYCuA==", //sandbox username
            "X-PinePerks-Token": pineToken
          }),
          queryParameters: {
            "minKycUniqueId": minKycUniqueId,
            "documentType": "",
            "nameOnDocument": "",
            "documentNumber": ""
          });
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
      } else {
        debugPrint("Error");
      }
    } catch (e) {
      debugPrint("error" + e.toString());
    }
  }
}
