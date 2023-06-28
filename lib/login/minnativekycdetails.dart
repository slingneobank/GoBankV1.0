import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/login/auth_controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class minnativekycdetails extends StatefulWidget {
  //String storekycid;
   minnativekycdetails({Key? key,
   // required this.storekycid
    }) : super(key: key);

  @override
  State<minnativekycdetails> createState() => _minnativekycdetailsState();
}

class _minnativekycdetailsState extends State<minnativekycdetails> {
  final TextEditingController documentNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addLine1Controller = TextEditingController();
  final TextEditingController _addLine2Controller = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  
  String _fullName = '';
  String _addLine1 = '';
  String _addLine2 = '';
  String _pincode = '';

  String? _selectedDate;
  String? _selectedGender;
  bool isSelected = false;
String _dialogMessage = '';
  int selectedDocumentType = 4; // Default value for Driving License
  String responseMessage = '';
    late DatabaseReference kycDetailsRef; // Declare the kycDetailsRef variable
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeFirebase();
   // print(widget.storekycid);
  }
   // Initialize Firebase
  void initializeFirebase() async {
    await Firebase.initializeApp();
    //kycDetailsRef = FirebaseDatabase.instance.reference().child('kyc_details').child('documentNumber');
  kycDetailsRef = FirebaseDatabase.instance.reference().child('kyc_details');
  }
 void verifyDocument() async{
 
    // Validate document and retrieve necessary parameters
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String? minKycUniqueId = sharedPreferences.getString('minKycUniqueId');
    
    int selectedDocument = selectedDocumentType; // Replace with your implementation
    String documentnumber=documentNumberController.text;
    // Store the KYC details in the database
    final newKycDetailsRef = kycDetailsRef.child(documentnumber).push();
    newKycDetailsRef.set({
      'minKycUniqueId': minKycUniqueId,
      'documentType': selectedDocument,
      'nameOnDocument': _fullNameController.text,
      'documentNumber': documentNumberController.text,
      'dateOfBirth': _selectedDate.toString(),
    }).then((value) {
      setState(() {
        responseMessage = 'KYC details stored successfully!';
      });

    }).catchError((error) {
      setState(() {
        responseMessage = 'Failed to store KYC details.';
      });
    });
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
          'KYC details',
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
            child: Container(
              height: MediaQuery.of(context).size.height, // Set a finite height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Enter details carefully',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Padding(
                                //   padding: EdgeInsets.symmetric(vertical: 4.0),
                                //   child: Container(
                                //     height: 50.0,
                                //     decoration: BoxDecoration(
                                //       border: Border.all(color: Colors.black),
                                //       borderRadius: BorderRadius.circular(8.0),
                                //     ),
                                //     child: Padding(
                                //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                                //       child: TextFormField(
                                //         controller: _aadharController,
                                //         decoration: InputDecoration(
                                //           contentPadding:
                                //               EdgeInsets.only(top: 12.0, bottom: 8.0),
                                //           hintText: 'Aadhar Card Number',
                                          
                                //           border: InputBorder.none,
                                //         ),
                                //         maxLength: 12,
                                //         keyboardType: TextInputType.number,
                                //         onChanged: (value) {
                                //           _aadharNumber = value;
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                        controller: _fullNameController,
                                        decoration: InputDecoration(
                                          hintText: 'Full Name',
                                          contentPadding:
                                              EdgeInsets.only(top: 12.0, bottom: 8.0),
                                          border: InputBorder.none,
                                        ),
                                        maxLength: 40,
                                        onChanged: (value) {
                                          _fullName = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                 Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            child: DropdownButton<int>(
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
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8.0),
                                            
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            child: TextFormField(
                                            controller: documentNumberController,
                                            decoration: InputDecoration(
                                            hintText: 'Document number',
                                            contentPadding:
                                                EdgeInsets.only(top: 12.0, bottom: 8.0),
                                            border: InputBorder.none,
                                                                                  ),
                                                                                  ),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                ).then((selectedDate) {
                                                  if (selectedDate != null) {
                                                    _selectedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                                                  }
                                                  print({_selectedDate});
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.calendar_today),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    _selectedDate != null
                                                        ? _selectedDate.toString()
                                                        : 'D.O.B',
                                                        overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                                            child: DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                hintText: 'Select Gender',
                                                border: InputBorder.none,
                                              ),
                                              value: _selectedGender,
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'Male',
                                                  child: Text('Male'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Female',
                                                  child: Text('Female'),
                                                ),
                                              ],
                                              onChanged: (value) {
                                                _selectedGender = value;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.0),
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
                                        controller: _addLine1Controller,
                                        decoration: InputDecoration(
                                          hintText: 'Address Line 1',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          _addLine1 = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
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
                                        controller: _addLine2Controller,
                                        decoration: InputDecoration(
                                          hintText: 'Address Line 2',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          _addLine2 = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
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
                                        controller: _pincodeController,
                                        decoration: InputDecoration(
                                          hintText: 'Pin Code',
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(top: 12.0, bottom: 8.0),
                                        ),
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          _pincode = value;
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
                  //Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      verifyDocument();
                      verifykycdocument();
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> verifykycdocument() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? authorizationToken = sharedPreferences.getString('token');
    String? minKycUniqueId = sharedPreferences.getString('minKycUniqueId');
    

    String  apiUrl = 'https://issuanceapis-uat.pinelabs.com/v1/kycs/mins/validations/document';
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
      'documentType': selectedDocumentType,
      'nameOnDocument': _fullNameController.text,
      'documentNumber': documentNumberController.text,
      'dateOfBirth': _selectedDate,
    };
    try {
      Map<String, dynamic> responseData = await ApiService.makeApiCall(apiUrl, headers, requestBody);

      setState(() {
        responseMessage = responseData['responseMessage'];
      });
      print(responseMessage);

      Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Home()),
              );
      setState(() {
                            _dialogMessage = 'KYC verified successfully';
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text(_dialogMessage),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                     
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
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
                //SystemNavigator.pop(); 
               // exit(0);//forcefully terminate app to background
              },
              child: Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                // Retry the token generation
                verifykycdocument();
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
