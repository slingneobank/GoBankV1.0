import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/cardAPI/digitalcardissuance.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class cardschema extends StatefulWidget {
  @override
  _cardschemaState createState() => _cardschemaState();
}

class _cardschemaState extends State<cardschema> {
  Map<String, dynamic> cardSchemes = {};
  String responseMessage = '';
  int responseCode = 0;
  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }
  Future<void> getCardSchemes() async {
    final url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/schemes');
    
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
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
     setState(() {
        responseMessage = jsonResponse.toString();
        if (jsonResponse['cardSchemes'] != null && jsonResponse['cardSchemes'].isNotEmpty) {
          cardSchemes = jsonResponse['cardSchemes'][0];
          int cardSchemeId = cardSchemes['cardSchemeId'];
          print(cardSchemeId);
          saveCardSchemeId(cardSchemeId);
        }
      });
      print(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load card schemes');
    }
  }
  Future<void> saveCardSchemeId(int cardSchemeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cardSchemeId', cardSchemeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Schemes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: getCardSchemes,
              child: Text('Generate Card Schemes'),
            ),
            OutlinedButton(
              onPressed: () {
                navigator!.push(MaterialPageRoute(builder: (context) => digitalcardissuance(),));
              },
              child: Text('Next to cardschemaid'),
            ),
            SizedBox(height: 20),
            Expanded(child: Text('Response Message: $responseMessage')),
            
          ],
        ),
      ),
    );
  }

  

  

  
}
