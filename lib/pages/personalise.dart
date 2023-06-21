import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/pages/checkout.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/media.dart';

class Personalise extends StatefulWidget {
  Personalise({Key? key}) : super(key: key);

  @override
  State<Personalise> createState() => _PersonaliseState();
}

class _PersonaliseState extends State<Personalise> {
  late ColorNotifire notifire;
  var enteredText = "Name";

  @override
  void initState() {
    super.initState();
    enteredText = "Enter Name";
    notifire = ColorNotifire(); // Initialize the notifire variable
    getdarkmodepreviousstate();
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

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Center( // Wrap the Column with a Center widget
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: h * 0.1,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Personalise Your Card",
                    style: TextStyle(
                        fontFamily: "Gilroy medium",
                        color: notifire.gettabwhitecolor,
                        fontSize: h / 35),
                  ),
                ),
              ),
              Container(
                height: h * .5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Image.asset('asset/images/card2.jpg'),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Text(
                          '$enteredText',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      top: h * .14,
                      right: 5,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 70,),
              Container(
                //padding: EdgeInsets.only(top: 20),
                height: h * 0.06,
                width: 230,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30), // Set a circular border radius
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.grey[800], // Adjust the fill color as per your requirement
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(Icons.person, color: Colors.white),
                        ), // Icon widget
                        SizedBox(width: 2), // Add some spacing between the icon and the TextField
                        VerticalDivider(color: Colors.white60,indent: 10,endIndent: 10,thickness: 1), // Divider widget
                        SizedBox(width: 2), // Add some spacing between the divider and the TextField
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Name",
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.transparent, // Set the fill color of the TextField to transparent
                              border: InputBorder.none, // Remove the border of the TextField
                              contentPadding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding as per your requirement
                            ),
                            style: TextStyle(color: Colors.white), // Adjust the text color as per your requirement
                            onChanged: (value) {
                              setState(() {
                                enteredText = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Container(
               // margin: EdgeInsets.only(top: 20),
                height: h * 0.06,
                width: 230,
                child: TextButton(
                  onPressed: () {
                    navigator!.push(
                      MaterialPageRoute(builder: (context) => checkOut()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Set a circular border radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
