import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/login/auth_ctrl.dart';
import 'package:gobank/login/minnativekycdetails.dart';
import 'package:gobank/pages/orderplaced.dart';
import 'package:gobank/pages/physicalcard_orderstatus.dart';
import 'package:gobank/profile/myprofile.dart';
import 'package:gobank/splashscreen.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/verifyOTP.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   onboard =  await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Get.put(AuthCtrl());
  Get.lazyPut(()=>AuthCtrl());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifire(),
          
        ),
        
      ],
      child: const GetMaterialApp(
        
       home: Splashscreen(),
      //home: orderplaced(),
        debugShowCheckedModeBanner: false,
      ),
    ),
    
  );
}
