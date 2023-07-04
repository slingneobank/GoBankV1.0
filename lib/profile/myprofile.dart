import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gobank/logoutbottomsheet.dart';
import 'package:gobank/profile/editprofile.dart';
import 'package:gobank/profile/weviewshow.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/colornotifire.dart';
import '../utils/string.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;
  late ColorNotifire notifire;
  List cashbankimg = [
    "images/merchant1.png",
    "images/cashback.png",
    "images/merchant1.png",
    "images/helpandsupport.png",
    "images/helpandsupport.png",
    "images/cashback.png",
    "images/merchant1.png",
  ];
  List cashbankname = [
    "Transaction History",
    CustomStrings.cashback,
    "Refer a Friend",
    CustomStrings.helpandsuppors,
    "About Us",
    "Privacy Policy",
    "Terms and Conditions"
  ];
  List cashbankdiscription = [
    "Transaction History",
    CustomStrings.scratchcards,
    CustomStrings.startsccepting,
    CustomStrings.relatedpaytm,
    "About Us",
    "Privacy Policy",
    "Terms and Conditions"
  ];
  List cashbankdiscription2 = [
    "",
    CustomStrings.scratchcards2,
    CustomStrings.startsccepting2,
    CustomStrings.relatedpaytm2,
    "",
    "",
    ""
  ];

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
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.transparent,
              child: Image.asset(
                "images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: height / 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: notifire.getdarkscolor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CustomStrings.myprofile,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontSize: height / 40,
                            fontFamily: 'Gilroy Bold'),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        },
                        child: Image.asset(
                          "images/editprofile.png",
                          height: height / 30,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Container(
                  height: height / 8,
                  width: width / 4,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("images/man4.png"),
                ),
                SizedBox(
                  height: height / 50,
                ),
                Text(
                  "Brooklyn Simmons",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height / 45,
                      fontFamily: 'Gilroy Bold'),
                ),
                Text(
                  "gilroy@email.com",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height / 55,
                      fontFamily: 'Gilroy Medium'),
                ),
                SizedBox(
                  height: height / 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "✅ ",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy Medium'),
                    ),
                    Text(
                      "Minimum KYC",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy Medium'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 70,
                ),
                const Text(
                  "Upgrade KYC",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gilroy Medium'),
                ),

                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: height / 15,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              "🎂 ",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                            Text(
                              "22/02/2222",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "📞 ",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                            Text(
                              "1992828888",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                          ],
                        )
                      ],
                    )),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: height / 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Current Plan",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Lite",
                                style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                height: height / 20,
                                width: height / 4,
                                decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Upgrade",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            "images/onbonding2.png",
                            height: height / 8,
                          )
                        ],
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Text(
                  "Quick Links",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: height / 45,
                      fontFamily: 'Gilroy Medium'),
                ),
                SizedBox(
                  height: height / 30,
                ),
                Container(
                  height: height / 1,
                  color: Colors.transparent,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: cashbankname.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 70),
                      child: InkWell(
                        onTap: () {
                         setState(() {
                          if(index==4 )
                          {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => webViewshow(urllink:"https://www.google.com/" ),));
                              //print("hi${cashbankdiscription[index]}");
                          }
                          else if(index==5)
                          {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => webViewshow(urllink: "https://www.google.com/"),));
                              //print("hi${cashbankdiscription[index]}");
                          }
                            
                         });
                        },
                        child: Container(
                          height: height / 9,
                          width: width,
                          decoration: BoxDecoration(
                            color: notifire.getdarkwhitecolor,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 20),
                            child: Row(
                              children: [
                                Container(
                                  height: height / 15,
                                  width: width / 7,
                                  decoration: BoxDecoration(
                                    color: notifire.gettabwhitecolor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      cashbankimg[index],
                                      height: height / 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height / 70,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          cashbankname[index],
                                          style: TextStyle(
                                              fontFamily: "Gilroy Bold",
                                              color: notifire.getdarkscolor,
                                              fontSize: height / 50),
                                        ),
                                        // SizedBox(width: width / 7,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 100,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cashbankdiscription[index],
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Medium",
                                                  color: notifire
                                                      .getdarkgreycolor
                                                      .withOpacity(0.6),
                                                  fontSize: height / 60),
                                            ),
                                            Text(
                                              cashbankdiscription2[index],
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Medium",
                                                  color: notifire
                                                      .getdarkgreycolor
                                                      .withOpacity(0.6),
                                                  fontSize: height / 60),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(Icons.arrow_forward_ios,
                                    color: notifire.getdarkscolor,
                                    size: height / 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 250),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: height / 8,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getdarkwhitecolor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Row(
                          children: [
                            Container(
                              height: height / 15,
                              width: width / 7,
                              decoration: BoxDecoration(
                                color: notifire.gettabwhitecolor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  "images/onbonding3.png",
                                  height: height / 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height / 70,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Loving Sling? Give us a rating to\nshow your love!",
                                      style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 50),
                                    ),
                                    // SizedBox(width: width / 7,),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 100,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rate Your Experience",
                                          style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: Colors.orange[300],
                                              fontSize: height / 60),
                                        ),
                                        Text(
                                          "★★★★★",
                                          style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              color: Colors.orange[300],
                                              fontSize: height / 60),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Row(
                //   children: [
                //     SizedBox(
                //       width: width / 20,
                //     ),
                //     Text(
                //       CustomStrings.fullnamee,
                //       style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: height / 50,
                //           fontFamily: 'Gilroy Medium'),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Profiletextfilds.textField(
                //     notifire.getdarkscolor,
                //     notifire.getdarkgreycolor,
                //     notifire.getbluecolor,
                //     CustomStrings.fullnames,
                //     notifire.getdarkwhitecolor),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: width / 20,
                //     ),
                //     Text(
                //       CustomStrings.email,
                //       style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: height / 50,
                //           fontFamily: 'Gilroy Medium'),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Profiletextfilds.textField(
                //     notifire.getdarkscolor,
                //     notifire.getdarkgreycolor,
                //     notifire.getbluecolor,
                //     CustomStrings.email,
                //     notifire.getdarkwhitecolor),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: width / 20,
                //     ),
                //     Text(
                //       CustomStrings.phonenumber,
                //       style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: height / 50,
                //           fontFamily: 'Gilroy Medium'),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Profiletextfilds.textField(
                //     notifire.getdarkscolor,
                //     notifire.getdarkgreycolor,
                //     notifire.getbluecolor,
                //     CustomStrings.phonenumbers,
                //     notifire.getdarkwhitecolor),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: width / 20,
                //     ),
                //     Text(
                //       CustomStrings.address,
                //       style: TextStyle(
                //           color: Colors.grey,
                //           fontSize: height / 50,
                //           fontFamily: 'Gilroy Medium'),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: height / 50,
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: width / 18),
                //   child: Container(
                //     color: Colors.transparent,
                //     height: height / 4,
                //     child: TextField(
                //       maxLines: 3,
                //       autofocus: false,
                //       style: TextStyle(
                //         fontSize: height / 50,
                //         color: notifire.getdarkscolor,
                //       ),
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.all(height / 100),
                //         filled: true,
                //         fillColor: notifire.getdarkwhitecolor,
                //         hintText: CustomStrings.address,
                //         hintStyle: TextStyle(
                //             color: notifire.getdarkgreycolor,
                //             fontSize: height / 60),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: notifire.getbluecolor,
                //           ),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: const BorderSide(
                //             color: Color(0xffd3d3d3),
                //           ),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                 Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 100),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: height / 15,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getdarkwhitecolor,
                        border: Border.all(
                          color: Colors.amber,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: OutlinedButton(
                          onPressed: () {
                             if (_scaffoldKey.currentState != null) {
                                  _bottomSheetController = _scaffoldKey.currentState!.showBottomSheet(
                                    (context) => const logoutbottomsheet(),
                                    elevation: 10,
                                    backgroundColor: Colors.transparent,
                                  );
                                }
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.amber, width: 2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20), // Set left and right padding to 20
                            minimumSize: Size(width-40,50 ), // Set button size to 50x50
                          ),
                          child: Text("Logout",style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          color: Colors.amber,
                                          fontSize: height / 35),),
                        )
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
  

}
