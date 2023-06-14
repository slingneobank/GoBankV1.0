import 'package:flutter/material.dart';
import 'package:gobank/home/sling_store/sling_store_musthave.dart';
import 'package:gobank/home/sling_store/sling_storebannerpage.dart';
import 'package:gobank/home/sling_store/sling_storegeeks_games.dart';
import 'package:gobank/home/sling_store/sling_storepacking.dart';
import 'package:gobank/home/sling_store/sling_storeshopessential.dart';
import 'package:gobank/home/sling_store/sling_storestyle.dart';
import 'package:gobank/home/sling_store/sling_storesuggestimg.dart';
import 'package:gobank/slingsaverclub/bannerpage.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
late ColorNotifire notifire;
class sling_storemain extends StatefulWidget {
  const sling_storemain({Key? key}) : super(key: key);

  @override
  State<sling_storemain> createState() => _sling_storemainState();
}

class _sling_storemainState extends State<sling_storemain> {
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
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
     body: Column(
      children: [
        Expanded(
              flex: 1,
              child: Container(
                 decoration: BoxDecoration(color: Colors.black87),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: notifire.getdarkwhitecolor,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                              
                  Text("Sling Store",
                         style: TextStyle(
                             fontFamily: "Gilroy Bold",
                            color: notifire.getdarkwhitecolor,
                            fontSize: height / 40,),
                        ),
                            
                  Center(
                    child: Text("My Orders",
                         style: TextStyle(
                               fontFamily: "Gilroy Medium",
                                color: notifire.getdarkwhitecolor,
                                fontSize: height / 40,),
                               ),
                             ),
                                        
                            ],
                          ),
                ),
              )),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                child: Container(
                  //height: MediaQuery.sizeOf(context).height,
                  //width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(color: Colors.black87),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Welcome To the Sling Store!",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        SizedBox(
                          height: 220,
                          child: sling_storebannerpage(),),
                        
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Sling Store Suggests🙂",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 200,
                            child: sling_storesuggestimg(),),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Shop Essentials",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 200,
                            child: sling_storeshopessential(),),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Find Your Style 👠",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 200,
                            child: sling_storestyle(),),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("For Geeks & Games 🎮",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 200,
                            child: sling_storegeeks_games(),),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Let's start packing🧳",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 160,
                            child: sling_storepacking(),),
                        ),
                        SizedBox(
                          height: height / 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Must Haves by Amazon 🛒 ",
                              style: TextStyle(
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getdarkwhitecolor,
                                      fontSize: height / 40,),
                            ),
                          ),
                          SizedBox(
                          height: height / 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: SizedBox(
                            height: 200,
                            child: sling_store_musthave(),),
                        ),
                         SizedBox(
                          height: height / 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
      ],
     )
    );
  }
}