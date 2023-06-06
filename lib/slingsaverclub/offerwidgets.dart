import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
late ColorNotifire notifire;
class offer1widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    
    getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
  notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child:  Column(
          children: [
               
                  Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10),
                   child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home(),));
                                },
                                 child: SizedBox(child: Row(
                                   children: [
                                     Icon(Icons.arrow_back_ios_new,color: Colors.black,),
                                     Text("Back",
                                      style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,),)
                                   ],
                                 )),
                               ),
                               Text("Sling Store",
                               style: TextStyle(
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,),
                               ),
                               Text("My Orders",
                               style: TextStyle(
                                        fontFamily: "Gilroy Medium",
                                        color: notifire.getdarkscolor,
                                        fontSize: height / 40,),
                               ),
                             ],
                           ),
                 
               ),
               SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.only(right: 10),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        
                        ),
                        child: Center(
                          child: Text("My Vouchers",
                                 style: TextStyle(
                                          fontFamily: "Gilroy Medium",
                                          color: notifire.getdarkscolor,
                                          fontSize: height / 40,),
                                 ),
                        ),
                    )
                  ],
                 ),
               ),
               SizedBox(

                height: 200,
                child:  Lottie.asset('asset/animation/offer1.json'),
               ),
               Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Be Smart with your money",
                                       style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkscolor,
                                                fontSize: height / 30,),
                                       ),
                      Text("Start Saving",
                                       style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                color: Colors.amber[700],
                                                fontSize: height / 30,),
                                       ),
                    ],
                  ),
                ),  
               ),
          ],
        ),
      )
    );
  }
}

class offer2widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 2')),
    );
  }
}


class offer3widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 3')),
    );
  }
}


class offer4widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 4')),
    );
  }
}


class offer5widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 5')),
    );
  }
}


class offer6widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 6')),
    );
  }
}


class offer7widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom UI for the custom widget
    return Container(
      child: Center(child: Text('image details 7')),
    );
  }
}