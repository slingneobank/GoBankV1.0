import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class physicalcard_orderstatus extends StatefulWidget {
  const physicalcard_orderstatus({super.key});

  @override
  State<physicalcard_orderstatus> createState() => _physicalcard_orderstatusState();
}

class _physicalcard_orderstatusState extends State<physicalcard_orderstatus> {
  String external_id="p-102";

 @override
  void initState() {
    super.initState();
    fetchCardOrderStatus();
  }

Future<void> fetchCardOrderStatus() async {
  try {
    // API endpoint URL
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/cards/orders/statuses/$external_id';

    // Set request headers (if required)
   Map<String, String> headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
      'content-type': 'application/json'
    };

    // Send the GET request
    http.Response response = await http.get(Uri.parse(apiUrl), headers: headers);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response JSON data
      Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
      // Process the response data as needed
      // For example, you can access the fields like this:
      String approvalCode = responseData['orderResponseList'][0]['approvalCode'];
      String referenceNumber = responseData['orderResponseList'][0]['referenceNumber'].toString();
      // ... and so on

      print('Approval Code: $approvalCode');
      print('Reference Number: $referenceNumber');
      // ... and other processing as needed
    } else {
      // Request failed, handle the error
      print('API Request failed with status code: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  } catch (e) {
    // Exception occurred while making the request
    print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}