import 'package:flutter/material.dart';
import 'package:gobank/utils/button.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:gobank/verification/scandone.dart';
import 'package:provider/provider.dart';

class VerifiyIdenty extends StatefulWidget {
  const VerifiyIdenty({Key? key}) : super(key: key);

  @override
  State<VerifiyIdenty> createState() => _VerifiyIdentyState();
}

class _VerifiyIdentyState extends State<VerifiyIdenty> {
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: notifire.getprimerycolor,
                  image: const DecorationImage(
                      image: AssetImage("images/background.png"),
                      fit: BoxFit.cover),),
            ),
            Column(
              children: [
                SizedBox(height: height / 20),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: notifire.getprimerycolor,),
                    ),
                  ],
                ),
                SizedBox(height: height / 30),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      CustomStrings.verify,
                      style: TextStyle(
                        color: notifire.getbluecolor,
                        fontSize: height / 25,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                    SizedBox(width: width / 40),
                    Text(
                      CustomStrings.identity,
                      style: TextStyle(
                        fontSize: height / 25,
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy Bold',
                      ),
                    )
                  ],
                ),
                SizedBox(height: height / 100),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      CustomStrings.nowweneedtoverifiy,
                      style: TextStyle(
                        color: notifire.getdarkgreycolor,
                        fontSize: height / 52,
                        fontFamily: 'Gilroy Medium',
                      ),
                    )
                  ],
                ),
                SizedBox(height: height / 15),
                identywidget("images/passwordscan.png",
                    CustomStrings.takeapassword, CustomStrings.passportscan),
                SizedBox(height: height / 40),
                identywidget("images/Illustration.png",
                    CustomStrings.selfwithfront, CustomStrings.selfie),
                SizedBox(height: height / 8.5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanDone(),
                      ),
                    );
                  },
                  child: Custombutton.button(
                    notifire.getbluecolor,
                    CustomStrings.submitall,
                    width / 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget identywidget(image, title, cliptitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: height / 4.5,
        width: width / 1.1,
        decoration: BoxDecoration(
          color: notifire.gettabwhitecolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 25),
                Image.asset(
                  image,
                  height: height / 10,
                ),
                SizedBox(width: width / 20),
                Text(
                  title,
                  style: TextStyle(
                    color: notifire.getdarkgreycolor,
                    fontSize: height / 52,
                    fontFamily: 'Gilroy Medium',
                  ),
                )
              ],
            ),
            SizedBox(height: height / 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(color: notifire.getdarkgreycolor),
            ),
            SizedBox(height: height / 100),
            Row(
              children: [
                SizedBox(width: width / 20),
                Image.asset(
                  "images/paperclip.png",
                  height: height / 30,
                ),
                SizedBox(width: width / 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliptitle,
                      style: TextStyle(
                        fontSize: height / 52,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                    Text(
                      CustomStrings.haventuploadyet,
                      style: TextStyle(
                        color: notifire.getdarkgreycolor,
                        fontSize: height / 52,
                        fontFamily: 'Gilroy Medium',
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
