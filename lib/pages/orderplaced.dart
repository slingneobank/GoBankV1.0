import 'package:flutter/material.dart';
import 'package:gobank/home/home.dart';
import 'package:gobank/profile/weviewshow.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

import '../utils/button.dart';

class orderplaced extends StatefulWidget {
  String urllink;
   orderplaced({Key? key,required this.urllink}) : super(key: key);

  @override
  State<orderplaced> createState() => _orderplacedState();
}

class _orderplacedState extends State<orderplaced> {
  late ColorNotifire notifire;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.urllink);
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
              color: notifire.getprimerycolor,
              child: Image.asset(
                "images/background.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(height: height / 5.5),
                Center(
                    child: Image.asset("images/verificationdone.png",
                        height: height / 3)),
                Text(
                  "Order placed sucessfully ",
                  style: TextStyle(
                      fontSize: height / 30,
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold'),
                ),
                SizedBox(height: height / 50),
                Text(
                  "Your card will be Delivered in 7 Days",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.getdarkgreycolor),
                ),
                SizedBox(height: height / 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  webViewshow(urllink: widget.urllink),
                      ),
                    );
                  },
                  child: Custombutton.button(
                      notifire.getbluecolor, "Pin set", width / 2.5),
                ),
                SizedBox(height: height / 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  child: Custombutton.button(
                      notifire.getbluecolor, CustomStrings.done, width / 1.1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
