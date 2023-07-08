import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobank/home/home_ctrl.dart';
import 'package:gobank/home/transfer/addmoneyvideo.dart';
import 'package:gobank/home/transfer/sendall.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colornotifire.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> with SingleTickerProviderStateMixin{

  late ColorNotifire notifire;

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

  @override
  void initState() {
    super.initState();
    //controller = TabController(length: 4, vsync: this);
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
                                          Text("₹ 0.0",
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
                                      child: Image.asset('asset/images/card2.jpg'),
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

class Loadmoneytoaccount extends StatefulWidget {
  const Loadmoneytoaccount({super.key});

  @override
  State<Loadmoneytoaccount> createState() => _LoadmoneytoaccountState();
}

class _LoadmoneytoaccountState extends State<Loadmoneytoaccount> {
  late ColorNotifire notifire;
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
    "50",
    "100",
    "500",
    "1000",
  
  ];
  int walletpriceindex = -1;
  List<Color> colorList = [
  Colors.greenAccent,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.orangeAccent,
  // Add more colors as needed
];

  @override
  void initState() {
    super.initState();
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
                                        Text("₹ 0.0",
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
                                    child: Image.asset('asset/images/card2.jpg'),
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
                                  SizedBox(
                                    child: Text( 
                                     walletpriceindex!= -1
                                        ? "₹ ${walletlistindex[walletpriceindex]}"
                                        : "₹ ${walletlistindex[0]}",
                                    style: TextStyle(
                                      fontFamily: "Gilroy bold",
                                      color: notifire.getdarkscolor,
                                      fontSize: height / 35,
                                     ),
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
                              await homeCtrl.razorpayCheckout(
                                context,  walletpriceindex!= -1
                                        ? "${walletlistindex[walletpriceindex]}"
                                        : "${walletlistindex[0]}", "Add Wallet");
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

