import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late ColorNotifire notifire;
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  bool _switchValue3 = false;
  bool _switchValue4 = false;

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
                    SizedBox(
                      height: height / 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: notifire.getdarkscolor,
                          ),
                        ),
                        SizedBox(
                          width: width / 3.5,
                        ),
                        Text(
                          CustomStrings.notification,
                          style: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy Bold',
                              fontSize: height / 40),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 35,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Row(
                        children: [
                          Text(
                            CustomStrings.setyournotification,
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy Bold',
                           fontSize: height / 47
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 50,),
                    genralnotification(CustomStrings.shownotifications),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.4),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: height / 200),
                    soundnotification(CustomStrings.financialactivity),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.4),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: height / 200),
                    vaibratenotification(CustomStrings.nonfinancialactivity),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.4),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: height / 200),
                    apecialnotification(CustomStrings.security),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 20),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.4),
                        thickness: 1,
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

  Widget genralnotification(title) {
    return Row(
      children: [
        SizedBox(width: width / 20),
        Image.asset("images/notification.png",height: height / 32,color: notifire.getdarkscolor,),
        SizedBox(width: width / 30,),
        Text(
          title,
          style: TextStyle(fontSize: height / 45, fontFamily: 'Gilroy Medium',color: notifire.getdarkscolor),
        ),
        const Spacer(),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            trackColor: notifire.getdarkgreycolor,
            thumbColor: Colors.white,
            activeColor: notifire.getbluecolor,
            value: _switchValue1,
            onChanged: (value) {
              setState(
                () {
                  _switchValue1 = value;
                },
              );
            },
          ),
        ),
        SizedBox(width: width / 20)
      ],
    );
  }

  Widget soundnotification(title) {
    return Row(
      children: [
        SizedBox(width: width / 20),
        Image.asset("images/activity.png",height: height / 32,color: notifire.getdarkscolor,),
        SizedBox(width: width / 30,),
        Text(
          title,
          style: TextStyle(fontSize: height / 45, fontFamily: 'Gilroy Medium',color: notifire.getdarkscolor),
        ),
        const Spacer(),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            trackColor: notifire.getdarkgreycolor,
            thumbColor: Colors.white,
            activeColor: notifire.getbluecolor,
            value: _switchValue2,
            onChanged: (value) {
              setState(
                () {
                  _switchValue2 = value;
                },
              );
            },
          ),
        ),
        SizedBox(width: width / 20)
      ],
    );
  }

  Widget vaibratenotification(title) {
    return Row(
      children: [
        SizedBox(width: width / 20),
        Image.asset("images/nonactivity.png",height: height / 32,color: notifire.getdarkscolor,),
        SizedBox(width: width / 30,),
        Text(
          title,
          style: TextStyle(fontSize: height / 45, fontFamily: 'Gilroy Medium',color: notifire.getdarkscolor),
        ),
        const Spacer(),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            trackColor: notifire.getdarkgreycolor,
            thumbColor: Colors.white,
            activeColor: notifire.getbluecolor,
            value: _switchValue3,
            onChanged: (value) {
              setState(
                () {
                  _switchValue3 = value;
                },
              );
            },
          ),
        ),
        SizedBox(width: width / 20)
      ],
    );
  }

  Widget apecialnotification(title) {
    return Row(
      children: [
        SizedBox(width: width / 20),
        Image.asset("images/security1.png",height: height / 30,color: notifire.getdarkscolor,),
        SizedBox(width: width / 30,),
        Text(
          title,
          style: TextStyle(fontSize: height / 45, fontFamily: 'Gilroy Medium',color: notifire.getdarkscolor),
        ),
        const Spacer(),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            trackColor: notifire.getdarkgreycolor,
            thumbColor: Colors.white,
            activeColor: notifire.getbluecolor,
            value: _switchValue4,
            onChanged: (value) {
              setState(
                () {
                  _switchValue4 = value;
                },
              );
            },
          ),
        ),
        SizedBox(width: width / 20)
      ],
    );
  }
}
