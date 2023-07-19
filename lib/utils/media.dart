import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic height;
dynamic width;
List indicator=[];
//int activeIndex = 0;
int activeindexslideroffers=0;
int activecontainerindex=0;
List containerindicator=[];
SharedPreferences? onboard; 

 Future<String> getVideoUrlFromStorage() async {
  // Assuming you have a reference to the video file in Firebase Storage
  Reference videoRef = FirebaseStorage.instance.ref().child('Video/addmoney.mp4');

  try {
    // Get the download URL for the video
    final videoUrl = await videoRef.getDownloadURL();
    return videoUrl;
  } catch (e) {
    print('Error fetching video URL: $e');
    // Handle the error accordingly
    return "https://www.youtube.com/watch?v=sD9IyJqSIaE";
  }
}

Future<bool> isFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_first_time') ?? true;
}

Future<void> saveFirstTimeStatus(bool isFirstTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_first_time', isFirstTime);
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_logged_in') ?? false;
}

Future<void> saveLoggedInStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_logged_in', isLoggedIn);
}

Future<bool> isVerified() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_verified') ?? false;
}

Future<void> saveVerificationStatus(bool isVerified) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_verified', isVerified);
}

Future<bool> isMINKYCComplete() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_minkyc_complete') ?? false;
}

Future<void> saveMINKYCStatus(bool isMINKYCComplete) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_minkyc_complete', isMINKYCComplete);
}
void showToast(String message) {
  Fluttertoast.showToast(
     msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
void showToasttop(String message) {
  Fluttertoast.showToast(
     msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}