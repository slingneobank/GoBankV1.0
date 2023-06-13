import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/apicalling/minkycnativeotp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<Map<String, dynamic>> makeApiCall(String apiUrl, Map<String, String> headers, dynamic requestBody) async {
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error in API call: $error');
    }
  }
}

class MinkycNative extends StatefulWidget {
  @override
  _MinkycNativeState createState() => _MinkycNativeState();
}

class _MinkycNativeState extends State<MinkycNative> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _response = '';

  @override
  void dispose() {
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }

  Future<void> _makeApiCall() async {
    String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/natives/initiate';

    String? token = await _getAuthorizationToken();
    if (token == null) {
      setState(() {
        _response = 'Authorization token not found';
      });
      return;
    }

    Map<String, String> headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
      'content-type': 'application/json',
    };

    dynamic requestBody = {
      "customerName": _nameController.text,
      "email": _emailController.text,
      "mobileNumber": int.parse(_mobileController.text),
    };

    try {
      Map<String, dynamic> responseData = await ApiService.makeApiCall(apiUrl, headers, requestBody);
    
        String minKycUniqueId = responseData['minKycUniqueId'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('minKycUniqueId', minKycUniqueId);

      setState(() {
        _response = responseData.toString();
      });
    } catch (error) {
      setState(() {
        _response = 'Error in API call: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Enter name',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Mobile Number:',
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _makeApiCall,
              child: Text('Make API Call'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => navigator!.push(MaterialPageRoute(builder: (context) => minKycNativeOtp(),)),
              child: Text('next to OTP verification'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Response:',
              style: TextStyle(fontSize: 18.0),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


