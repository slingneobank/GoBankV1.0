import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class digitalcard_detail extends StatefulWidget {
  const digitalcard_detail({Key? key}) : super(key: key);

  @override
  _digitalcard_detailState createState() => _digitalcard_detailState();
}

class _digitalcard_detailState extends State<digitalcard_detail> {
  bool isLoading = true;
  String? referenceNumber;
  String responseMessage = '';
  Map<String, dynamic> cardData = {};

  @override
  void initState() {
    super.initState();
    getReferenceNumber();
    fetchData();
  }

  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  Future<void> getReferenceNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? number = prefs.getString('referenceNumber');
    setState(() {
      referenceNumber = number;
    });
  }

  Future<Map<String, dynamic>> fetchCardDetails() async {
    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        responseMessage = 'Authorization token not found';
      });
      return {};
    }

    final response = await http.get(
     // Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/attributes/$referenceNumber'),
      Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/attributes/8455376964'),
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['cardDetailResponse'];
    } else {
      throw Exception('Failed to fetch card details');
    }
  }

  Future<void> fetchData() async {
    try {
      final cardDetails = await fetchCardDetails();
      if (cardDetails.isNotEmpty) {
        setState(() {
          isLoading = false;
          cardData = cardDetails;
        });
      }
    } catch (error) {
      setState(() {
        responseMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: Text(
          "Digital Card details",
          style: TextStyle(
            fontFamily: "Gilroy medium",
            color: Colors.white,
            fontSize: height / 35,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Perform an action
            },
            icon: const Icon(Icons.candlestick_chart_rounded),
          ),
        ],
      ),
      body: isLoading ? showLoadingScreen() : showContent(),
    );
  }

  Widget showLoadingScreen() {
    return Shimmer(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey,
          Colors.grey,
          Colors.black,
          Colors.grey,
          Colors.grey,
        ],
      ),
      period: Duration(seconds: 2),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
        ),
        title: Container(
          width: double.infinity,
          height: 20,
          color: Colors.grey,
        ),
        subtitle: Container(
          width: double.infinity,
          height: 15,
          color: Colors.grey,
        ),
        trailing: Container(
          width: 70,
          height: double.infinity,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Number: ${cardData['maskedCardNumber']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Account Number: ${cardData['accountNumber']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            // Display other card details as needed
            Text(
              'Card Scheme ID: ${cardData['cardSchemeId']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Card Variant: ${cardData['cardVariant']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Issued On: ${cardData['issuedOn']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Activated On: ${cardData['activatedOn']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'Expiry Date: ${cardData['expiryDate']}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            // Display other card details as needed
          ],
        ),
      ),
    );
  }
}
