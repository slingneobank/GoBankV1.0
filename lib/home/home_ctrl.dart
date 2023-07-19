import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
    cardReloadAfterPaymentSuccess(amount);
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

  Future<void> cardReloadAfterPaymentSuccess(int amount) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? cardSchemeId = prefs.getInt('cardSchemeId');
      String? referenceNumber = prefs.getString('referenceNumber');
       String uniqueNumber = const Uuid().v4();
      var url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/reloads/instant');
      var headers = {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
        'content-type': 'application/json',
      };
      var body = json.encode({
        "externalRequestId": "pay-$uniqueNumber",
        "cardSchemeId": cardSchemeId,
        "cardIdentifier": 1,
        "referenceNumber": referenceNumber,
        "amount": amount,
      });

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        log("API Response: $jsonResponse");
        // Process the API response here
      } else {
        log("API Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      log("API Error: $e");
    }
  }
