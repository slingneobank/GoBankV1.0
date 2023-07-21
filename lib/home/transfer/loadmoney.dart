import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/home/transfer/addmoneyvideo.dart';
import 'package:gobank/home/transfer/sendall.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../../utils/colornotifire.dart';
class Loadmoneytoaccount extends StatefulWidget {
  const Loadmoneytoaccount({super.key});

  @override
  State<Loadmoneytoaccount> createState() => _LoadmoneytoaccountState();
}

class _LoadmoneytoaccountState extends State<Loadmoneytoaccount> {
  late ColorNotifire notifire;
  
TextEditingController walletamount=TextEditingController();
dynamic wallet_amount;
dynamic selectedAmountFromListView;
  final homeCtrl = Get.find<HomeCtrl>();
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
 List walletlistindex = [
    "100",
    "500",
    "1000",
    "2000",
  
  ];
  int walletpriceindex = -1;
  List<Color> colorList = [
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.orangeAccent,
  // Add more colors as needed
];
    String referenceNumber = '';
    int? cardschemeid;
  SharedPreferences? prefs;
  var loadAmount = 0;
  @override
  void initState() {
    super.initState();
    _loadReferenceNumber();
    getReferenceNumberFromSharedPreferences();
    walletamount.text=walletlistindex[0];
  }
   Future<void> _loadReferenceNumber() async {
    prefs = await SharedPreferences.getInstance();
    referenceNumber = prefs!.getString('referenceNumber') ?? '';
    cardschemeid=prefs!.getInt('cardSchemeId');
    print(referenceNumber);
    print(cardschemeid);
    setState(() {});
  }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Expanded(
              child: SizedBox(),
                
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
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                                        Text("₹ $loadAmount",
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
                          SizedBox(height: 10,),
                         Text("You can add Funds up to Rs.10000.0 for the current month",
                                          style: TextStyle(
                                            fontFamily: "Gilroy medium",
                                            color: notifire.getdarkgreycolor,
                                            fontSize: height / 55,
                                           ),
                            ),
                        SizedBox(height: 50,),
                          Text("Add money to your account",
                                          style: TextStyle(
                                            fontFamily: "Gilroy Bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 45,
                                           ),
                            ),
                            SizedBox(height: 20,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12,bottom: 12,left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                        child: TextField(
                                          controller: walletamount,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            fontFamily: "Gilroy bold",
                                            color: notifire.getdarkscolor,
                                            fontSize: height / 35,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (value) {
                                            wallet_amount=walletamount.text;
                                           },
                                        ),
                                        
                                      ),
                                  
                                  
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                              height: 35,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 5,right: 5),
                                scrollDirection: Axis.horizontal,
                                itemCount: walletlistindex.length,
                                itemBuilder: (context, index) {
                                  String price = walletlistindex[index];
                                  Color color = colorList[index % 4]; // Generate color based on index modulo 4 for a repeating pattern
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                            setState(() {
                                              walletpriceindex = index;
                                              walletamount.text=walletlistindex[walletpriceindex];
                                              wallet_amount=walletamount.text;
                                            });
                                         },
                                      child: Container(
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "₹$price",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height / 50,
                                              fontFamily: 'Gilroy bold',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 50,),
                          InkWell(
                            onTap: () async{
                              // await homeCtrl.razorpayCheckout(
                              //   context,wallet_amount, "Add Wallet");
                                  
                                int enteredAmount = int.tryParse(wallet_amount) ?? 0;
                                int minimumAmount = 100;

                                if (enteredAmount >= minimumAmount) {
                                  // Navigate to razorpayCheckout if wallet_amount is greater than or equal to 50
                                  await homeCtrl.razorpayCheckout(context, wallet_amount, "Add Wallet");
                                } else {
                                  // Show dialog box if wallet_amount is less than 50
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Wallet Amount"),
                                        content: Text("Wallet amount must be at least ₹100"),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context); // Close the dialog box
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                            },
                            child: Container(
                              height: 50,
                              //width: width-40,
                              decoration: BoxDecoration(
                                color: Colors.amber[700],
                                borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text("Add (₹)",
                                       style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height / 40,
                                                  fontFamily: 'Gilroy bold',
                                                ),
                                  ),
                                ),
                            ),
                          ),
                          SizedBox(height: 25,),
                           Center(
                             child: Container(
                               height: 60,
                               width: width-80,
                               decoration: BoxDecoration(
                                 color: Colors.amber[300],
                                 borderRadius: BorderRadius.circular(20)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
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
                                             fontSize: height / 50,
                                            ),
                                          ),
                                          Text("Watch this video",
                                           style: TextStyle(
                                             fontFamily: "Gilroy medium",
                                             color: notifire.getdarkscolor,
                                             fontSize: height / 55,
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
                                       height: 30,
                                       width: 50,
                                       decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         color: notifire.getdarkscolor
                                                               
                                       ),
                                       child: Icon(
                                         Icons.arrow_right,
                                         color: notifire.getdarkwhitecolor,
                                         size: 30,
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

