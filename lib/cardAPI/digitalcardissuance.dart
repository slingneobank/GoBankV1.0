import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class digitalcardissuance extends StatefulWidget {
  @override
  _digitalcardissuanceState createState() => _digitalcardissuanceState();
}

class _digitalcardissuanceState extends State<digitalcardissuance> {
  TextEditingController amountController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController orderDescriptionController = TextEditingController();
  TextEditingController externalRequestIdController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController externalCardIdentifierController =
      TextEditingController();
  int? cardSchemeId;
  String responseMessage = '';
  int responseCode = 0;

  @override
  void initState() {
    super.initState();
    getCardSchemeId();
  }

  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }

  Future<void> getCardSchemeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('cardSchemeId');
    setState(() {
      cardSchemeId = id;
    });
  }

Future<void> createDigitalCardOrder() async {
  final url = Uri.parse(
      'https://issuanceapis-uat.pinelabs.com/v1/cards/digitals/orders/instant');

  String? token = await _getAuthorizationToken();
  if (token == null) {
    setState(() {
      responseMessage = 'Authorization token not found';
    });
    return;
  }

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer $token',
    'content-type': 'application/json',
  };

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('cardSchemeId');

  int cardSchemeId = id!;

  final body = json.encode({
    "amount": int.parse(amountController.text),
    "mobileNumber": int.parse(mobileNumberController.text),
    "orderDescription": orderDescriptionController.text,
    "externalRequestId": externalRequestIdController.text,
    "customerName": customerNameController.text,
    "email": emailController.text,
    "externalCardIdentifier": externalCardIdentifierController.text,
    "cardSchemeId": cardSchemeId,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        responseMessage = jsonResponse['responseMessage'];
      });

      //Store data in Realtime Database
      String phoneNumber = mobileNumberController.text;
      Map<String, dynamic> data = {
        'amount': int.parse(amountController.text),
        "mobileNumber": int.parse(mobileNumberController.text),
        "orderDescription": orderDescriptionController.text,
        "externalRequestId": externalRequestIdController.text,
        "customerName": customerNameController.text,
        "email": emailController.text,
        "externalCardIdentifier": externalCardIdentifierController.text,
        "cardSchemeId": cardSchemeId,
      };
      await storeData(phoneNumber, data);

      print(jsonResponse);
      return jsonResponse;
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
     
    }
  } catch (e) {
    setState(() {
      responseMessage = 'Error: ${e.toString()}';
    });
  }
}


  Future<void> storeData(String phoneNumber, Map<String, dynamic> data) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference.child('digital_card_issuance').child(phoneNumber).set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Card Issuance'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Card Scheme ID:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                cardSchemeId != null ? cardSchemeId.toString() : 'N/A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('Response Message: $responseMessage'),
              SizedBox(height: 20),
              Text('Create Digital Card Order'),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(labelText: 'Amount'),
                    ),
                    TextField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(labelText: 'Mobile Number'),
                    ),
                    TextField(
                      controller: orderDescriptionController,
                      decoration:
                          InputDecoration(labelText: 'Order Description'),
                    ),
                    TextField(
                      controller: externalRequestIdController,
                      decoration:
                          InputDecoration(labelText: 'External Request ID'),
                    ),
                    TextField(
                      controller: customerNameController,
                      decoration: InputDecoration(labelText: 'Customer Name'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: externalCardIdentifierController,
                      decoration: InputDecoration(
                          labelText: 'External Card Identifier'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: createDigitalCardOrder,
                      child: Text('Create Digital Card Order'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
