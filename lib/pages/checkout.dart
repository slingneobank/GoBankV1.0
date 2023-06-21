import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/utils/media.dart';

import 'box.dart';
// import 'form.dart';

class checkOut extends StatelessWidget {
 
 checkOut({Key? key}) : super(key: key);
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController roadNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
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
                  child: Text(
                    "help?",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          // height: h,
          width: w,
          child: Column(
            children: [
              Text("Order Card",
                 style: TextStyle(fontFamily: "Gilroy Bold",
                           color: Colors.white,
                           fontSize: height / 35)),
              SizedBox(height: 30,),
              box(),
              SizedBox(height: 30,),
              Form(
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
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
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
                           enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
                        
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
                           enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
                        
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
                           enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
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
                           enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
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
                           enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                        ),
                      ),
                    style: TextStyle(color: Colors.white),
                        
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Container(
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
                              }
                            },
                            child: Text('Pay - \u{20B9}199',
                            style: TextStyle(fontFamily: "Gilroy Bold",
                               color: Colors.black,
                               fontSize: height / 45)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
