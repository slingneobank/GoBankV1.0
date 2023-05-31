import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeCtrl extends GetxController {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  razorpayCheckout(context, amount,desc) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddkkmms');
    final String formatted = formatter.format(now);
    final time = formatted + DateTime.now().millisecondsSinceEpoch.toString();

    Razorpay razorpay = Razorpay();

    var options = {
      //test kye = "rzp_test_AekDI8A3TUkwE3"     || live key ="rzp_live_GXUisZOKVEDiTE"
      'key': 'rzp_test_AekDI8A3TUkwE3',
      'amount': int.parse('${amount}00'),
      'name': "Payvoy",
      'description': desc,
      // 'prefill': {'contact': user.mobile!, 'email': user.email}
    };
    void handlePaymentSuccess(PaymentSuccessResponse response) async {
      // Do something when payment succeeds
      log("PAYMENT SUCCCESSFUL");
    }

    void handlePaymentError(PaymentSuccessResponse response) async {
      // Do something when payment succeeds
      log("PAYMENT FAILURE");
    }

    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    razorpay.clear();
  }
}
