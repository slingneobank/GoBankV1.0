import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/utils/media.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;
import '../home/home_ctrl.dart';
import 'box.dart';
// import 'form.dart';
class checkOut extends StatefulWidget {
  const checkOut({super.key});

  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  
  final homeCtrl = Get.find<HomeCtrl>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController roadNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  SharedPreferences? prefs;
  String? referenceNumber;
  int? cardschemeid;
  String?nameofcard;
  String? uniqueNumber;
  String? token;
  String?username;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loaddata();
  }
  Future<void> _loaddata() async {
    prefs = await SharedPreferences.getInstance();
    referenceNumber = prefs!.getString('referenceNumber') ?? '';
    cardschemeid=prefs!.getInt('cardSchemeId');
    nameofcard=prefs!.getString('nameofcard');
    token= prefs!.getString('token');
    username= prefs!.getString('username');
    print(referenceNumber);
    print(cardschemeid);
    print(nameofcard);
    print(token);
    print(username);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
              
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "help?",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            )
          ]),
      body: SingleChildScrollView(
        child: SizedBox(
          width: w,
          child: Column(
            children: [
              Text("Order Card",
                 style: TextStyle(fontFamily: "Gilroy Bold",
                           color: Colors.white,
                           fontSize: height / 35)),
              const SizedBox(height: 30,),
              const box(),
              const SizedBox(height: 30,),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: pinCodeController,
                          decoration: InputDecoration(
                            labelText: 'Pin Code*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter your pin code',
                            hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a pin code';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: stateController,
                          decoration: InputDecoration(
                            labelText: 'State*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter your state',
                            hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                             enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a state';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            labelText: 'City*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter your city',
                            hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                             enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a city';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: houseNumberController,
                          decoration: InputDecoration(
                            labelText: 'House Number,Building Name*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter your house number and building name',
                          hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                             enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a house number';
                            }
                            return null;
                          },
                        ),
                        
                        TextFormField(
                          controller: roadNameController,
                          decoration: InputDecoration(
                            labelText: 'Road Name/Area/Colony',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter your road name, area, colony',
                          hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                             enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a road name, area, colony';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: landmarkController,
                          decoration: InputDecoration(
                            labelText: 'Landmark (Optional)',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                            hintText: 'Enter a landmark (optional)',
                            hintStyle: TextStyle(fontFamily: "Gilroy medium",
                             color: Colors.white60,
                             fontSize: height / 45),
                             enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      style: const TextStyle(color: Colors.white),
                          
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: SizedBox(
                            height: 40,
                            width: width,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            
                              ),
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {
                                  // Perform form submission
                                  // e.g., save the data or make an API call
                                    String houseNumber = houseNumberController.text;
                                  String roadName = roadNameController.text;
                                  String city = cityController.text;
                                  String state = stateController.text;
                                  String pinCode = pinCodeController.text;
                                  await homeCtrl.razorpayphysicalcheckout(
                                      context,
                                      199,
                                      "Add Wallet",
                                      houseNumber,
                                      roadName,
                                      city,
                                      state,
                                      pinCode,
                                    );
                                }
                               
                                  
              
                                // physicalcardissuance();
                                // Navigator.pop(context);
                                
                              },
                              child: Text('Pay - \u{20B9}199',
                              style: TextStyle(fontFamily: "Gilroy Bold",
                                 color: Colors.black,
                                 fontSize: height / 45)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


Future<void> physicalcardissuance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    referenceNumber = prefs.getString('referenceNumber') ?? '';
  String url = 'https://issuanceapis-uat.pinelabs.com/v1/cards/digitals/physicals/instant';
  
String uniqueNumber = const Uuid().v4();
  Map<String, dynamic> requestBody = {
    "address": {
      "addressLine1": houseNumberController.text,
      "addressLine2": roadNameController.text,
      "city": cityController.text,
      "state": stateController.text,
      "pinCode": pinCodeController.text,
    },
    "pinMode": 1,
    "cardSchemeId": cardschemeid,
    "referenceNumber": referenceNumber,
    "externalRequestId": uniqueNumber,
    "isContactless": 1,
    "cardIdentifier": 1,
    "customerName": username,
    "nameOnCard": nameofcard
  };

  Map<String, String> headers = {
    'accept': 'application/json',
    'authorization': 'Bearer $token',
    'content-type': 'application/json'
  };

  try {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Successfully received the response
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData); // The parsed response data
      // Store the pinSetLink from the response into a variable
      String pinSetLink = responseData['pinSetLink'];
      print('Pin Set Link: $pinSetLink');

      // Store the response data into Firebase Realtime Database
      final databaseReference = FirebaseDatabase.instance.reference();
      databaseReference.child('Sling_physicalcard_response').child(referenceNumber!).set(responseData);

      // Or if you want to store it under a specific node, for example, "issued_cards":
      // databaseReference.child('issued_cards').child(uniqueNumber).set(responseData);
    
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error making the request: $e');
  }
}
}
