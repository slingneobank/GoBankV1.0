import 'package:firebase_core/firebase_core.dart';
import 'package:gobank/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth?auth1;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth1=FirebaseAuth.instance;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifire(),
        ),
      ],
      child: const MaterialApp(
        home: Splashscreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
    
  );
}
