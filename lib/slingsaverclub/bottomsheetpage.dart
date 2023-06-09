import 'package:flutter/material.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
late ColorNotifire notifire;
class bottomsheetpage extends StatelessWidget {
  const bottomsheetpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  ScrollController _scrollController = ScrollController(); // Create a new ScrollController
  
    return ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                        child: Container(
                                          height: 450,
                                          color: Colors.white,
                                          child:  Column(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  //color: Colors.red,
                                                  child: Column(
                                                    children: [ 
                                                      InkWell(
                                                        onTap: () => Navigator.pop(context),
                                                        child: Icon(
                                                          Icons.expand_more,size: 25,),
                                                          ),
                                                      ListTile(
                                                        leading: Icon(Icons.brightness_medium,size: 40),
                                                        title: Text(
                                                          'Rebook',
                                                          style: TextStyle(
                                                        fontFamily: "Gilroy Bold",
                                                        color: notifire.getdarkscolor,
                                                        fontSize: height / 50),),
                                                        subtitle: Text(
                                                          'Get Instant 10% cashback in rebook ',
                                                          style: TextStyle(
                                                        fontFamily: "Gilroy Medium",
                                                        color: notifire.getdarkgreycolor,
                                                        fontSize: height / 50),
                                                          ),
                                                      ),
                                                  ],
                                                                                               ),
                                                ),
                                              ),
                                             Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 10),
                                                  child: Scrollbar(
                                                    isAlwaysShown: true,
                                                    controller: _scrollController,
                                                    thickness: 3,
                                                    child: SingleChildScrollView(
                                                      controller: _scrollController,
                                                      physics: ClampingScrollPhysics(),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Text("OFFER DETAILS",style: TextStyle(
                                                                fontFamily: "Gilroy Bold",
                                                                color: notifire.getdarkscolor,
                                                                fontSize: height / 50),
                                                                ),
                                                              ),
                                                              const Divider(
                                                              color: Colors.grey,
                                                              thickness: 0.5,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 10,),
                                                            Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              
                                                         SizedBox(height: 20,),
                                                         Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Text("TERMS & CONDITION",style: TextStyle(
                                                                fontFamily: "Gilroy Bold",
                                                                color: notifire.getdarkscolor,
                                                                fontSize: height / 50),
                                                                ),
                                                              ),
                                                              const Divider(
                                                              color: Colors.grey,
                                                              thickness: 0.5,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 10,),
                                                            Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                               SizedBox(height: 10,),
                                                            Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          SizedBox(height: 10,),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 10,),
                                                            Padding(
                                                                padding: const EdgeInsets.only(left: 20),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.circle,size: 10,),
                                                                    SizedBox(width: 5,),
                                                                    Text("Get 10% instant cashbackon your purchase",style: TextStyle(
                                                                    fontFamily: "Gilroy Medium",
                                                                    color: notifire.getdarkgreycolor,
                                                                    fontSize: height / 50),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          ],
                                                         ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                             Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    children: [
                                                      OutlinedButton(onPressed:() {
                                                        
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                        backgroundColor: Colors.black,
                                                        padding: EdgeInsets.symmetric(vertical: 13,horizontal: 25),
                                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),)
                                                      ),
                                                
                                                       child: Text(
                                                        "shop Now",
                                                        style: TextStyle(
                                                          fontFamily: "Gilroy Medium",
                                                          color: notifire.getdarkwhitecolor,
                                                          fontSize: height / 50),),
                                                          ),
                                                          SizedBox(height: 30,),
                                                      const Divider(
                                                        height: 5,
                                                        color: Colors.black,
                                                        thickness: 3,
                                                        indent: 120,
                                                        endIndent: 120,
                                                        )
                                                    ],
                                                   ),
                                                ),
                                              )
                                            ],
                                          )

                                        ),
                                      );
  }
}