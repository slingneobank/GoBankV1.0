import 'package:flutter/material.dart';
import 'package:gobank/login/setyourpin.dart';
import 'package:gobank/utils/button.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

class VerifiyIdenty extends StatefulWidget {
  const VerifiyIdenty({Key? key}) : super(key: key);

  @override
  State<VerifiyIdenty> createState() => _VerifiyIdentyState();
}

class _VerifiyIdentyState extends State<VerifiyIdenty> {
  late ColorNotifire notifire;
  String docVal = "Pan Card";
  List<String> docItems = [
    "Pan Card",
    "Passport",
    "Driving License",
    "Voter's ID"
  ];
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
                    fit: BoxFit.cover),
              ),
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
                      child: Icon(
                        Icons.arrow_back,
                        color: notifire.getprimerycolor,
                      ),
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
                SizedBox(height: height / 50),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Text(
                      "Select a Document",
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontSize: height / 50,
                          fontFamily: 'Gilroy Bold'),
                    )
                  ],
                ),
                SizedBox(height: height / 80),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    Container(
                      height: height / 17,
                      width: width / 1.4,
                      decoration: BoxDecoration(
                        color: notifire.gettabwhitecolor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        // Initial Value
                        value: docVal,

                        // Down Arrow Icon
                        icon: Row(
                          children: [
                            SizedBox(width: width / 2.5),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: notifire.getdarkscolor,
                            ),
                          ],
                        ),

                        // Array list of items
                        items: docItems.map((String docs) {
                          return DropdownMenuItem(
                            value: docs,
                            child: Row(
                              children: [
                                SizedBox(width: width / 50),
                                Text(
                                  docs,
                                  style: TextStyle(fontSize: height / 60),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            docVal = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height / 15),
                identywidget("images/passwordscan.png",
                    CustomStrings.takeapassword, CustomStrings.passportscan),
                // SizedBox(height: height / 40),
                // identywidget("images/Illustration.png",
                //     CustomStrings.selfwithfront, CustomStrings.selfie),
                SizedBox(height: height / 8.5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Setyourpin(),
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
