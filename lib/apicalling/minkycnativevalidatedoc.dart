import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Minkycnativevalidatedoc extends StatefulWidget {
  @override
  _MinkycnativevalidatedocState createState() => _MinkycnativevalidatedocState();
}

class _MinkycnativevalidatedocState extends State<Minkycnativevalidatedoc> {
  
  final TextEditingController nameOnDocumentController = TextEditingController();
  final TextEditingController documentNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  

  int selectedDocumentType = 4; // Default value for Driving License
  String responseMessage = '';

  Future<void> makeApiRequest() async {
    final url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/validations/document');

    final sharedPreferences = await SharedPreferences.getInstance();
    final authorizationToken = sharedPreferences.getString('token');
    final minKycUniqueId = sharedPreferences.getString('minKycUniqueId');

    final headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $authorizationToken',
      'content-type': 'application/json',
    };

    final body = jsonEncode({
      'minKycUniqueId': minKycUniqueId,
      'documentType': selectedDocumentType,
      'nameOnDocument': nameOnDocumentController.text,
      'documentNumber': documentNumberController.text,
      'dateOfBirth': dateOfBirthController.text,
     // 'issueDate': issueDateController.text,
      //'state': stateController.text,
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
        title: Text('Document Validation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            DropdownButton<int>(
              value: selectedDocumentType,
              onChanged: (value) {
                setState(() {
                  selectedDocumentType = value!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Pan Card'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('Passport'),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text('Driving License'),
                ),
                DropdownMenuItem<int>(
                  value: 5,
                  child: Text("Voter's ID"),
                ),
              ],
            ),
            TextField(
              controller: nameOnDocumentController,
              decoration: InputDecoration(
                labelText: 'Name on Document',
              ),
            ),
            TextField(
              controller: documentNumberController,
              decoration: InputDecoration(
                labelText: 'Document Number',
              ),
            ),
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
            ),
            
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: makeApiRequest,
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}
