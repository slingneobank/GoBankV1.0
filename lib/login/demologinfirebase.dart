import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:gobank/login/minnativekycdetails.dart';
import 'package:gobank/login/minnativekycotp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseHelper {
  final databaseReference = FirebaseDatabase.instance.reference();

  void storeData(String firebaseToken, String minKycUniqueId, String phoneNumber, String username) {
    databaseReference.child('kyc_users').child(phoneNumber).set({
      'firebaseToken': firebaseToken,
      'minKycUniqueId': minKycUniqueId,
      'phoneNumber': phoneNumber,
      'username': username,
    });
  }

Future<String?> retrieveMinKycUniqueId(String phoneNumber) async {
  try {
    DatabaseReference reference = databaseReference.child('kyc_users').child(phoneNumber).child('minKycUniqueId');
    DataSnapshot snapshot = await reference.once().then((event) => event.snapshot);
    dynamic value = snapshot.value;
    print(value);
    if (value != null) {
      return value.toString();
    }
    return null;
  } catch (error) {
    print('Error retrieving value: $error');
    return null;
  }
}





  Future<bool> checkPhoneNumber(String phoneNumber) async {
  try {
    DatabaseReference reference = databaseReference.child('kyc_users').child(phoneNumber);
    DataSnapshot snapshot = await reference.once().then((event) => event.snapshot);
    return snapshot.value != null;
  } catch (error) {
    print('Error retrieving DataSnapshot: $error');
    return false;
  }
}

}

class demologinfirebase extends StatefulWidget {
  const demologinfirebase({Key? key}) : super(key: key);

  @override
  State<demologinfirebase> createState() => _demologinfirebaseState();
}

class _demologinfirebaseState extends State<demologinfirebase> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _response = '';

  @override
  void dispose() {
    _usernameController.dispose();
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
      "customerName": _usernameController.text,
      "email": _emailController.text,
      "mobileNumber": int.parse(_mobileController.text),
    };

    try {
      Map<String, dynamic> responseData = await ApiService.makeApiCall(apiUrl, headers, requestBody);
      //FirestoreHelper firestoreHelper = FirestoreHelper();

      String minKycUniqueId = responseData['minKycUniqueId'] ?? '' ; //?? ''

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('minKycUniqueId', minKycUniqueId);
      String responseMessage = responseData['responseMessage'];
      setState(() {
        _response = responseData.toString();
      });
      print(_response);
      
      
       if (responseMessage == "Customer with the given mobile number is already Min KYC compliant") {
                String enteredPhoneNumber = _mobileController.text;
                bool isPhoneNumberMatched = await FirebaseHelper().checkPhoneNumber(enteredPhoneNumber);
                print("isPhoneNumberMatched: $isPhoneNumberMatched");
                
                if (isPhoneNumberMatched==true) {
                  String? storedminKycUniqueId = await FirebaseHelper().retrieveMinKycUniqueId(enteredPhoneNumber);
                  if (storedminKycUniqueId != null) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('storedminKycUniqueId', storedminKycUniqueId);
                        print("minkycid is $storedminKycUniqueId");

                        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                        return; // Return after navigating to the home screen
                      } 
                      else {
                        print("Value for key 'minKycUniqueId' is null.");
                      }

                  } else {
                  
                    print("phone number not matched");
                  }
              }
      FirebaseHelper().storeData(token, minKycUniqueId, _mobileController.text, _usernameController.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => minnativekycotp()));
    } catch (error) {
      setState(() {
        _response = 'Error: $error';
      });
      print(_response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Min Native KYC Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              ElevatedButton(
                onPressed: _makeApiCall,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              Text(_response),
            ],
          ),
        ),
      ),
    );
  }
}


