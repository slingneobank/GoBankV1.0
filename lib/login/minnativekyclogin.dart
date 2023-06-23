import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class minnativekyclogin extends StatefulWidget {
  const minnativekyclogin({Key? key}) : super(key: key);

  @override
  State<minnativekyclogin> createState() => _minnativekycloginState();
}

class _minnativekycloginState extends State<minnativekyclogin> {
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
        automaticallyImplyLeading: true,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.arrow_back_outlined,
        //     color: Colors.black,
        //   ),
        // ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile Section',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.card_giftcard,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool _hasContentOverflow =
              constraints.maxHeight < MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            physics: _hasContentOverflow
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Enter details carefully',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        hintText: 'Username(can be different than FullName)',
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 40,
                                      onChanged: (value) {
                                      //  _username = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _mobileController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        hintText: 'Mobile No.',
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                       // _mobile = "+91" + value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        contentPadding:
                                            EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        border: InputBorder.none,
                                      ),
                                      maxLength: 40,
                                      onChanged: (value) {
                                       // _email = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      _makeApiCall();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => minnativekycotp()));
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('next section')),
                      // );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                   
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
  
  