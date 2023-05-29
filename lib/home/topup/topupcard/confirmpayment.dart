import 'package:flutter/material.dart';
import 'package:gobank/bottombar/bottombar.dart';
import 'package:gobank/card/inoutpayment.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/button.dart';
import '../../../utils/colornotifire.dart';
import '../../../utils/media.dart';
import '../../../utils/string.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({Key? key}) : super(key: key);

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
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

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 20),
            Row(
              children: [
                SizedBox(width: width / 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: notifire.getdarkscolor,),
                ),
                SizedBox(
                  width: width / 4.5,
                ),
                Text(
                  CustomStrings.confirmpayment,
                  style: TextStyle(
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 40,
                    color: notifire.getdarkscolor
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 20),
            Text(
              CustomStrings.enteryourpin,
              style: TextStyle(
                fontFamily: 'Gilroy Bold',
                fontSize: height / 30,
                color: notifire.getdarkscolor
              ),
            ),
            SizedBox(height: height / 80),
            Text(
              CustomStrings.pleasepayment,
              style: TextStyle(
                color: notifire.getdarkgreycolor,
                fontFamily: 'Gilroy Medium',
                fontSize: height / 60,
              ),
            ),
            SizedBox(height: height / 30),
            animatedBorders(),
            SizedBox(height: height / 1.8),
            GestureDetector(
              onTap: () {
                _showMyDialog();
              },
              child: Custombutton.button(notifire.getbluecolor,
                  CustomStrings.confirmpayment, width / 1.1),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          child: Container(
            decoration:  BoxDecoration(
              color: notifire.gettabwhitecolor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: height / 2,
            child: Column(
              children: [
                SizedBox(
                  height: height / 40,
                ),
                Image.asset(
                  "images/paymentsuccess.png",
                  height: height / 5,
                ),
                SizedBox(
                  height: height / 40,
                ),
                Text(
                  CustomStrings.paymentsuccessful,
                  style: TextStyle(
                    color: notifire.getbluecolor,
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 40,
                  ),
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  CustomStrings.paying,
                  style: TextStyle(
                    color: notifire.getdarkgreycolor,
                    fontFamily: 'Gilroy Bold',
                    fontSize: height / 60,
                  ),
                ),
                SizedBox(
                  height: height / 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InOutPayment(),),);
                  },
                  child: buttons(notifire.getbluecolor, CustomStrings.viewreceipt,
                      Colors.white),
                ),
                SizedBox(
                  height: height / 60,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Bottombar(),),);
                  },
                    child: buttons(const Color(0xffd3d3d3), CustomStrings.home,
                        notifire.getbluecolor),),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttons(clr, txt, clr2) {
    return Container(
      height: height / 20,
      width: width / 2,
      decoration: BoxDecoration(
        color: clr,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
              color: clr2, fontSize: height / 60, fontFamily: 'Gilroy Bold'),
        ),
      ),
    );
  }

  Widget animatedBorders() {
    return Container(
      color: notifire.getprimerycolor,
      height: height / 14,
      width: width / 1.2,
      child: PinPut(
        textStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Gilroy Bold",
            fontSize: height / 40),
        fieldsCount: 4,
        eachFieldWidth: width / 6.5,
        withCursor: false,
        submittedFieldDecoration: BoxDecoration(
                color: notifire.gettabwhitecolor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor))
            .copyWith(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: notifire.getbluecolor)),
        selectedFieldDecoration: BoxDecoration(
            color:  notifire.gettabwhitecolor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: notifire.getbluecolor)),
        followingFieldDecoration: BoxDecoration(
          border: Border.all(color: notifire.getbluecolor),
          color: notifire.gettabwhitecolor,
          borderRadius: BorderRadius.circular(10.0),
        ).copyWith(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
