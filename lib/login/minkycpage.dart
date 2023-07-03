import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:gobank/login/minnativekyclogin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class minkycpage extends StatefulWidget {
  const minkycpage({Key? key}) : super(key: key);

  @override
  State<minkycpage> createState() => _minkycpageState();
}

class _minkycpageState extends State<minkycpage> {
  bool isSelected = false;
  String responseMessage = '';
  bool isLoading = false;
  Future<void> generateToken(String username, String apiKey) async {
    AuthController authController = AuthController();
    setState(() {
      isLoading = true;
    });
    try {
      Future.delayed(Duration(seconds: 2), () async{
      String? token = await authController.generateToken(username, apiKey);
      
      setState(() {
        responseMessage = 'Token generated successfully. Refresh Token: $token';
      });
       setState(() {
        isLoading = false;
      });
       print(token);
    });
     
      // Navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => minnativekyclogin()),
      );
      print(responseMessage);
    } catch (e) {
      setState(() {
        responseMessage = 'Error: $e';
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
                //Navigator.of(context).pop();
                SystemNavigator.pop();
                // exit(0);//forcefully terminate app to background
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                generateToken(username, apiKey);
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
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(''),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                        'Complete Account Setup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'As per RBI Guidelines, you have to verify your identity to open your account',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('asset/images/adhar.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          title: Text(
                            'Aadhar Card',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.green : Colors.grey,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            "Don't have an Aadhar card?",
                            style: TextStyle(color: Colors.amber),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/images/adhar.png',
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Trusted by 15 lakh families',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/images/adhar.png',
                            width: 25,
                            height: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Takes one minute to complete',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Center(
                        child: Text("Powered by"),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 25,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('asset/images/adhar.png'),
                        ),
                      ),
                      SizedBox(height: 80),  
                      GestureDetector(
                        onTap: () {
                          generateToken('payvoy.uatuser', 'X4oVUECF9EWhX9');
                          //Navigator.push(context,MaterialPageRoute(builder: (context) => minnativekyclogin()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: isLoading
                            ? CircularProgressIndicator()
                              : Text(
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
              ));
        },
      ),
    );
  }
}
