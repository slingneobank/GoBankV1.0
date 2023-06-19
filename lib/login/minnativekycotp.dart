import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gobank/login/minnativekycdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_controller.dart';


class minnativekycotp extends StatefulWidget {
  const minnativekycotp({Key? key}) : super(key: key);

  @override
  State<minnativekycotp> createState() => _minnativekycotpState();
}

class _minnativekycotpState extends State<minnativekycotp> {
  String responseMessage = '';
  List<TextEditingController?> controls = List.filled(6, null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Enter OTP here',
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    OtpTextField(
                      handleControllers: (controllers) {
                          //get all textFields controller, if needed
                          controls = controllers;
                        },
                      numberOfFields: 6,
                      fillColor: Colors.black.withOpacity(0.2),
                      filled: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              kycotpverification();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) => minnativekycdetails()),
              // );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('next section')),
              );
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
         // SizedBox(height: 10,),
        ],
      ),
    );
  }

  Future<void> kycotpverification() async {
    String apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/validations/otp';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? authorizationToken = sharedPreferences.getString('token');
    String? minKycUniqueId = sharedPreferences.getString('minKycUniqueId');
   List<String> otp = controls.map((controller) => controller?.text ?? '').toList();
    print("minkycid:$minKycUniqueId");
    if (authorizationToken == null || minKycUniqueId == null) {
      setState(() {
        responseMessage = 'Authorization token or minKycUniqueId not found';
      });
      return;
    }

    Map<String, String> headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $authorizationToken',
      'content-type': 'application/json',
    };

    dynamic requestBody = {
      'minKycUniqueId': minKycUniqueId,
      'otp': otp,
    };

    try {
      Map<String, dynamic> responseData = await ApiService.makeApiCall(apiUrl, headers, requestBody);

      setState(() {
        responseMessage = responseData['responseMessage'];
      });
      print(responseMessage);
      Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => minnativekycdetails()),
              );

    } catch (error) {
      setState(() {
        responseMessage = 'Error in API call: $error';
      });
      print(responseMessage);
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(responseMessage),
          content: Text('An error occurred. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                // Exit the app
                Navigator.of(context).pop();
               // SystemNavigator.pop(); 
               // exit(0);//forcefully terminate app to background
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                kycotpverification();
                Navigator.of(context).pop();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
  }
}
