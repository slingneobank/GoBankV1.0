import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colornotifire.dart';
import '../utils/itextfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late ColorNotifire notifire;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  bool _obscureText2 = true;
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
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
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
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
                SizedBox(height: height / 20,),
                Row(
                  children: [
                    SizedBox(width : width / 20,),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,color: notifire.getdarkscolor),),
                    SizedBox(width: width / 6,),
                    Text(
                      CustomStrings.createnewpassword,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy Bold',
                        fontSize: height / 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50,),
                Text(
                  CustomStrings.accessaccount,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 60,
                  ),
                ),
                SizedBox(height: height / 40,),
                Row(
                  children: [
                    SizedBox(width: width / 20,),
                    Text(
                      CustomStrings.newpassword,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy Bold',
                        fontSize: height / 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Customtextfild2.textField(
                    _obscureText,
                    "Password",
                    Colors.grey,
                    notifire.getdarkscolor,
                    "images/password.png",
                    GestureDetector(
                        onTap: () {
                          _toggle();
                        },
                        child: _obscureText
                            ? Image.asset("images/eye.png",height: height / 60,)
                            : const Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        )),
                    notifire.getbluecolor,
                    notifire.getdarkwhitecolor
                  ),
                ),
                SizedBox(height: height / 50,),
                Row(
                  children: [
                    SizedBox(width: width / 20,),
                    Text(
                      CustomStrings.confirmnewpassword,
                      style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy Bold',
                        fontSize: height / 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Customtextfild2.textField(
                      _obscureText2,
                      "Password",
                      Colors.grey,
                      notifire.getdarkscolor,
                      "images/password.png",
                      GestureDetector(
                          onTap: () {
                            _toggle2();
                          },
                          child: _obscureText2
                              ? Image.asset("images/eye.png",height: height / 60,)
                              : const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),),
                      notifire.getbluecolor,notifire.getdarkwhitecolor
                  ),
                ),
                SizedBox(height: height / 50,),
                Row(
                  children: [
                    SizedBox(width: width / 20,),
                    Image.asset("images/match.png",height: height / 40,),
                    SizedBox(width: width / 100,),
                    Text(
                      CustomStrings.passwordmatch,
                      style: TextStyle(
                        color: const Color(0xff00BF71),
                        fontFamily: 'Gilroy Medium',
                        fontSize: height / 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 2.2,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 17,
                      width: width,
                      decoration: BoxDecoration(
                        color: notifire.getbluecolor,
                        borderRadius: const BorderRadius.all(Radius.circular(30),),
                      ),
                      child: Center(
                        child: Text(CustomStrings.createpasswords,style: TextStyle(color: Colors.white,fontFamily: 'Gilroy Medium',
                            fontSize: height / 50
                        ),),
                      ),
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
