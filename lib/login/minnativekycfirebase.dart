import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
}
// class FirestoreHelper {
//   final CollectionReference kycUsersCollection =
//       FirebaseFirestore.instance.collection('kyc_users_data');

//   Future<void> storeData(
//       String firebaseToken, String minKycUniqueId, String phoneNumber, String username) async {
//     await kycUsersCollection.doc(phoneNumber).set({
//       'firebaseToken': firebaseToken,
//       'minKycUniqueId': minKycUniqueId,
//       'phoneNumber': phoneNumber,
//       'username': username,
//     });
//   }
// }
class minnativekycloginfirebase extends StatefulWidget {
  const minnativekycloginfirebase({Key? key}) : super(key: key);

  @override
  State<minnativekycloginfirebase> createState() => _minnativekycloginfirebaseState();
}

class _minnativekycloginfirebaseState extends State<minnativekycloginfirebase> {
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

      String minKycUniqueId = responseData['minKycUniqueId'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('minKycUniqueId', minKycUniqueId);
      String responseMessage = responseData['responseMessage'];
      setState(() {
        _response = responseData.toString();
      });
      print(_response);
      if (responseMessage == "Customer with the given mobile number is already Min KYC compliant") {
        // Redirect to KYC details screen
        // await firestoreHelper.storeData(
        // token, minKycUniqueId, _mobileController.text, _usernameController.text);
    
        FirebaseHelper().storeData(token, minKycUniqueId, _mobileController.text, _usernameController.text);
        Navigator.push(context, MaterialPageRoute(builder: (_) => minnativekycdetails()));
      } else {
        // Redirect to OTP screen
        // await firestoreHelper.storeData(
        // token, minKycUniqueId, _mobileController.text, _usernameController.text);
   
        FirebaseHelper().storeData(token, minKycUniqueId, _mobileController.text, _usernameController.text);
        Navigator.push(context, MaterialPageRoute(builder: (_) => minnativekycotp()));
      }
    } catch (error) {
      setState(() {
        _response = 'Error in API call: $error';
      });
      print(_response);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(_response),
          content: Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                // Exit the app
                Navigator.of(context).pop();
                //SystemNavigator.pop();
                // exit(0);//forcefully terminate app to background
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                _makeApiCall();
                Navigator.of(context).pop();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          bool _hasContentOverflow = constraints.maxHeight < MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            physics: _hasContentOverflow ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
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
                                        contentPadding: EdgeInsets.only(top: 12.0, bottom: 8.0),
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
                                        contentPadding: EdgeInsets.only(top: 12.0, bottom: 8.0),
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
                                        contentPadding: EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        hintText: 'Email',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        // _email = value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              ElevatedButton(
                                onPressed: _makeApiCall,
                                child: Text('Submit'),
                              ),
                              SizedBox(height: 16.0),
                              Text(_response),
                            ],
                          );
                        },
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





