
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colornotifire.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

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

  List imgs = [
    "images/pay1.png",
    "images/pay2.png",
    "images/pay3.png",
    "images/pay4.png",
    "images/pay1.png",
    "images/pay2.png",
  ];
  List names = [
    CustomStrings.rebrcca,
    CustomStrings.tiana,
    CustomStrings.susilo,
    CustomStrings.bambang,
    CustomStrings.rebrcca,
    CustomStrings.tiana,
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
       backgroundColor: notifire.getprimerycolor,

    );
  }




  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
