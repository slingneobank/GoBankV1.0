import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/home/transfer/addmoneyvideo.dart';
import 'package:gobank/home/transfer/loadmoney.dart';
import 'package:gobank/home/transfer/sendall.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../utils/colornotifire.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> with SingleTickerProviderStateMixin{
  late ColorNotifire notifire;
    var loadAmount = 0;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
 // TabController? controller;
  // List<Widget> tabs = [
  //   const SendAll(),
  //   const SendAll(),
  //   const SendAll(),
  //   const SendAll(),
  // ];
    String referenceNumber = '';
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    //controller = TabController(length: 4, vsync: this);
    _loadReferenceNumber();
    getReferenceNumberFromSharedPreferences();
  
  }
 Future<void> _loadReferenceNumber() async {
    prefs = await SharedPreferences.getInstance();
    referenceNumber = prefs!.getString('referenceNumber') ?? '';
    print(referenceNumber);
    setState(() {});
  }





// Future<void> fetchCardSchemeId(String referenceNumber) async {
//   try {
//     final databaseReference = FirebaseDatabase.instance.reference();
//     DatabaseEvent event = await databaseReference
//         .child('card_responses')
//         .child(referenceNumber)
//         .once();
//     DataSnapshot snapshot = event.snapshot;

//     // Print the entire snapshot.value to understand its structure
//     print('Snapshot Value: ${snapshot.value}');
//     prefs = await SharedPreferences.getInstance();
//     referenceNumber = prefs!.getString('referenceNumber') ?? '';
//     print(referenceNumber);
//     // Check if the snapshot exists and contains data
//     if (snapshot.value != null) {
//       Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
//       Map<dynamic, dynamic>? cardDetailResponse = data?[referenceNumber]?['cardDetailResponse'];
//       int? cardSchemeId = cardDetailResponse?['cardSchemeId'];
       
//       if (cardSchemeId != null) {
//         print('Card Scheme Id: $cardSchemeId');
//       } else {
//         print('Card Scheme Id not found in the snapshot.');
//       }
//       await prefs!.setInt('cardSchemeId', cardSchemeId!);
//     } else {
//       print('Reference number not found.');
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//   }
// }

 Future<void> getReferenceNumberFromSharedPreferences() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    referenceNumber = sharedPreferences.getString('referenceNumber')??'';

    if (referenceNumber.isNotEmpty) {
      makeGetRequest(referenceNumber);
    } else {
      setState(() {
        loadAmount = 0;
      });
    }
  }
  Future<void> makeGetRequest(String referenceNumber) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    var url = Uri.parse('https://issuanceapis-uat.pinelabs.com/v1/cards/balances/$referenceNumber');

    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        loadAmount = data['loadAmount'];
      });
      print(response.body);
      print("loadamount$loadAmount");
    } else {
      setState(() {
        loadAmount = 0;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbluecolor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: notifire.getbluecolor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: notifire.getdarkgreycolor),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7,right: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: notifire.getdarkwhitecolor,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        title: Text("Load Money",
        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: notifire.getdarkwhitecolor,
                          fontSize: height / 40),
        ),
      ),
      body: Container(
        //decoration: BoxDecoration(color: notifire.getbluecolor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Text(
                      "Load Money to Your account directly or share your QR code with parents or relatives",
                  style: TextStyle(
                              fontFamily: "Gilroy medium",
                              color: notifire.getdarkwhitecolor,
                              fontSize: height / 50),
                  ),
                ),
            ),
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                ),
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color:notifire.getdarkwhitecolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12,bottom: 12,left: 15,right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("₹$loadAmount ",
                                          style: TextStyle(
                                            fontFamily: "Gilroy bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 45,
                                           ),
                                         ),
                                         Text("Available Balance",
                                          style: TextStyle(
                                            fontFamily: "Gilroy bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 45,
                                           ),
                                         )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Image.asset('asset/images/card.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                         Text("You can add Funds up to Rs.10000.0 for the current month",
                                          style: TextStyle(
                                            fontFamily: "Gilroy medium",
                                            color: notifire.getdarkgreycolor,
                                            fontSize: height / 55,
                                           ),
                            ),
                        SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Loadmoneytoaccount(),));
                        },
                        child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text("Add via Debit Card / UPI",
                                         style: TextStyle(
                                           fontFamily: "Gilroy bold",
                                           color: notifire.getdarkscolor,
                                           fontSize: height / 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Icon(Icons.arrow_forward_ios)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ),
                          SizedBox(height: 50,),
                           Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.amber[300],
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Image.asset("images/wallet.png"),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("How to add Money?",
                                          style: TextStyle(
                                            fontFamily: "Gilroy bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 45,
                                           ),
                                         ),
                                         Text("Watch this video",
                                          style: TextStyle(
                                            fontFamily: "Gilroy medium",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 50,
                                           ),
                                         )
                                        ],
                                      ),
                                    ),
                                   InkWell(
                                    onTap: () async{
                                      String videoUrl = await getVideoUrlFromStorage();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => addmoneyvideo(videoUrl: videoUrl),
                                          ),
                                        );
                                    },
                                     child: Container(
                                      height: 35,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: notifire.getdarkscolor
                                                       
                                      ),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: notifire.getdarkwhitecolor,
                                        size: 35,
                                        ),
                                     ),
                                   )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
              ))
          ],
            
        ),
      ),
    );
  }
 

}

