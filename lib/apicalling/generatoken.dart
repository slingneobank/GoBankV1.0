import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/apicalling/minkycnative.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GenerateTokenScreen extends StatefulWidget {
  @override
  _GenerateTokenScreenState createState() => _GenerateTokenScreenState();
}

class _GenerateTokenScreenState extends State<GenerateTokenScreen> {
  String responseMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Token'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Generate Token'),
              onPressed: () {
                generateToken('payvoy.uatuser', 'X4oVUECF9EWhX9');
              },
            ),
            ElevatedButton(
              child: Text('next'),
              onPressed: () {
                navigator!.push(MaterialPageRoute(builder: (context) => MinkycNative(),));
              },
            ),
            SizedBox(height: 20),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }

  Future<void> generateToken(String username, String apiKey) async {
    final String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/auths/tokens/signin';

    Map<String, String> headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
    };

    Map<String, String> body = {
      'username': username,
      'apiKey': apiKey,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data['responseCode'] == 0) {
          String refreshToken = data['refreshToken'];
          String token = data['token'];

          setState(() {
            responseMessage = 'Token generated successfully. Refresh Token: $refreshToken';
          });

          // Store the token in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          // Navigate to the next screen or perform other operations

        } else {
          String responseMessage = data['responseMessage'];
          setState(() {
            responseMessage = 'Error: $responseMessage';
          });
        }
      } else {
        setState(() {
          responseMessage = 'Error: HTTP ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = 'Error: $e';
      });
    }
  }
}



class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    setState(() {
      token = storedToken ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Token: $token'),
      ),
    );
  }
}


