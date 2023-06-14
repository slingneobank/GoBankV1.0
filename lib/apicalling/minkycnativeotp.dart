import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/apicalling/minkycnativevalidatedoc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class minKycNativeOtp extends StatefulWidget {
  @override
  _minKycNativeOtpState createState() => _minKycNativeOtpState();
}

class _minKycNativeOtpState extends State<minKycNativeOtp> {
  final TextEditingController otpController = TextEditingController();

  String responseMessage = '';

  Future<void> makeApiRequest() async {
    final url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/validations/otp');

    final sharedPreferences = await SharedPreferences.getInstance();
    final authorizationToken = sharedPreferences.getString('token');
    final minKycUniqueId = sharedPreferences.getString('minKycUniqueId');
    final otp = otpController.text;

    final headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $authorizationToken',
      'content-type': 'application/json',
    };

    final body = jsonEncode({
      'minKycUniqueId': minKycUniqueId,
      'otp': int.parse(otp),
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Request successful
      setState(() {
        responseMessage = responseData['responseMessage'];
      });
    } else {
      // Request failed
      setState(() {
        responseMessage = 'Request failed with status code ${response.statusCode}\n'
            'Response message: ${responseData['responseMessage']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: makeApiRequest,
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
             ElevatedButton(
              onPressed: () => navigator!.push(MaterialPageRoute(builder: (context) => Minkycnativevalidatedoc(),)),
              child: Text('next to verify documnet'),
            ),
            SizedBox(height: 16.0),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}
