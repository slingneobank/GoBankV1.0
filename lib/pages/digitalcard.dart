import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/pages/digitalcard_detail.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../utils/media.dart';
 late ColorNotifire notifire;
class digitalcard extends StatefulWidget {
  const digitalcard({Key? key}) : super(key: key);

  @override
  _digitalcardState createState() => _digitalcardState();
}

class _digitalcardState extends State<digitalcard> {
  TextEditingController amountController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController orderDescriptionController = TextEditingController();
  TextEditingController externalRequestIdController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController externalCardIdentifierController =TextEditingController();
  TextEditingController cardSchemeController = TextEditingController();

  int? cardSchemeId;
  String responseMessage = '';
  int responseCode = 0;
 final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getCardSchemeId();
     notifire = ColorNotifire(); // Initialize the notifire variable
    getdarkmodepreviousstate();
    getuserdetails();
   String uniqueNumber = const Uuid().v4();
   externalCardIdentifierController.text = uniqueNumber;
    externalRequestIdController.text = uniqueNumber;
  }
  
      getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  Future<String?> _getAuthorizationToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    return token;
  }
  String?username;
  String? mobile;
  String? email;
   Future<void> getuserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username= prefs.getString('username');
    mobile= prefs.getString('mobileNumber');
    email=prefs.getString('email');
    mobileNumberController.text=mobile! ?? '';
    emailController.text=email! ?? '';
    customerNameController.text=username! ?? '';
    setState(() {});
  }
  Future<void> getCardSchemeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('cardSchemeId');
    
    setState(() {
      cardSchemeId = id;
       cardSchemeController.text = cardSchemeId != null ? cardSchemeId.toString() : 'N/A';
    });
  }

Future<void> createDigitalCardOrder() async {
  final url = Uri.parse(
      'https://issuanceapis-uat.pinelabs.com/v1/cards/digitals/orders/instant');

  String? token = await _getAuthorizationToken();
  if (token == null) {
    setState(() {
      responseMessage = 'Authorization token not found';
    });
    return;
  }

  final headers = {
    'accept': 'application/json',
    'authorization': 'Bearer $token',
    'content-type': 'application/json',
  };

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('cardSchemeId');

  if (id == null) {
    setState(() {
      responseMessage = 'Card scheme ID not found';
    });
    return;
  }

  int cardSchemeId = id;

  final body = json.encode({
    "amount": int.tryParse(amountController.text) ?? 0,
    "mobileNumber": int.tryParse(mobileNumberController.text) ?? 0,
    "orderDescription": orderDescriptionController.text,
    "externalRequestId": externalRequestIdController.text,
    "customerName": customerNameController.text,
    "email": emailController.text,
    "externalCardIdentifier": externalCardIdentifierController.text,
    "cardSchemeId": cardSchemeId,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Response Body: ${response.body}');
      final databaseReference = FirebaseDatabase.instance.reference();
      final phoneNumber = mobileNumberController.text;
      final data = {
        'referenceNumber': jsonResponse['referenceNumber'],
        'phoneNumber': phoneNumber,
      };
      await databaseReference
          .child('digital_card_issuance')
          .child(phoneNumber)
          .set(data);

      setState(() {
        responseMessage = jsonResponse['responseMessage'];
      });
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),));
      setState(() {
        
      });
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      setState(() {
        responseMessage = 'API request failed';
      });
    }
  } catch (e) {
    print('Error: $e');
    setState(() {
      responseMessage = 'Error occurred while making the API request';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
          Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        centerTitle: true,
        title:  Text('Create Digital Card Order',
                style: TextStyle(fontFamily: "Gilroy Bold",
                           color: notifire.getdarkwhitecolor,
                           fontSize: height / 35),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.headset_mic)),
        ],
      ),
      body: Container(
        color: notifire.getdarkscolor,
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                  Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cardSchemeController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'cardSchemeID*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter a cardSchemeID',
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
                              return 'Please enter a cardSchemeID';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          enabled: false,
                          controller: externalRequestIdController,
                          decoration: InputDecoration(
                            labelText: 'ExtrenalRequestID*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter your extrenalRequestID',
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
                              return 'Please enter a extrenalRequestID';
                            }
                            return null;
                          },
                        ),
                        
                        TextFormField(
                          enabled: false,
                          controller: externalCardIdentifierController,
                          decoration: InputDecoration(
                            labelText: 'ExternalCardIdentifier',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter your ExternalCardIdentifier',
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
                              return 'Please enter a ExternalCardIdentifier';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter your Amount',
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
                              return 'Please enter a Amount';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          enabled:  false,
                          controller: mobileNumberController,
                          decoration: InputDecoration(
                            labelText: 'Mobile No*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter your Mobile number',
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
                              return 'Please enter a Mobile number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: orderDescriptionController,
                          decoration: InputDecoration(
                            labelText: 'Order Description*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter your order Description',
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
                              return 'Please enter a Order Description';
                            }
                            return null;
                          },
                        ),
                        
                        TextFormField(
                          enabled: false,
                          controller: customerNameController,
                          decoration: InputDecoration(
                            labelText: 'Customer Name*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter Your name',
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
                              return 'Please enter a Your name';
                            }
                            return null;
                          },
                        ),
                        
                        
                        TextFormField(
                          enabled: false,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email*',
                            labelStyle: TextStyle(fontFamily: "Gilroy medium",
                            color: Colors.white60,
                            fontSize: height / 45),
                            hintText: 'Enter a Email',
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
                              return 'Please enter a Email';
                            }
                            return null;
                          },
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Perform form submission
                                  // e.g., save the data or make an API call
                                  createDigitalCardOrder();
                                }
                              },
                              child: Text('Submit',
                              style: TextStyle(fontFamily: "Gilroy Bold",
                                color: Colors.black,
                                fontSize: height / 45)),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
