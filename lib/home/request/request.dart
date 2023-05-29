import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colornotifire.dart';
import '../../utils/media.dart';
import '../../utils/string.dart';
import 'all.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> with SingleTickerProviderStateMixin{
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
  TabController? controller;
  List<Widget> tabs = [
    const All(),
    const All(),
    const All(),
    const All(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: notifire.getbluecolor,
        onPressed: () {
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                    SizedBox(height: height / 20,),
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
                          SizedBox(width: width / 4.5,),
                          Text(
                            CustomStrings.requestpayment,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: height / 40,
                                fontFamily: 'Gilroy Bold'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 50,),
                    serarchtextField(
                      Colors.black,
                      CustomStrings.search,
                    ),
                    SizedBox(height: height / 80,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Container(
                        height: height / 1.2,
                        color: Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: notifire.gettabcolor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(height / 200),
                                child: TabBar(
                                  labelStyle: const TextStyle(fontFamily: 'Gilroy Bold'),
                                  indicator: BoxDecoration(
                                      color: notifire.gettabwhitecolor,
                                      borderRadius:  BorderRadius.circular(10)
                                  ) ,
                                  indicatorColor: notifire.gettabcolor,
                                  controller: controller,
                                  labelColor: notifire.getdarkscolor,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: const [
                                    Tab(text: CustomStrings.all),
                                    Tab(text: CustomStrings.favorite),
                                    Tab(text: CustomStrings.bank),
                                    Tab(text: CustomStrings.ewallet),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: controller,
                                children: tabs.map((tab) => tab).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget serarchtextField(textclr, hinttext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 18),
      child: Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          autofocus: false,
          style: TextStyle(
            fontSize: height / 50,
            color: textclr,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: notifire.gettabwhitecolor,
            hintText: hinttext,
            prefixIcon: const Icon(Icons.search,color: Colors.grey,),
            suffixIcon: Icon(
              Icons.add_road,
              color: notifire.getbluecolor,
            ),
            hintStyle: TextStyle(color: Colors.grey, fontSize: height / 55),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

}
