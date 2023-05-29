import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gobank/login/setyourpin.dart';
import 'package:gobank/utils/button.dart';
import 'package:gobank/utils/colornotifire.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

class ScanDone extends StatefulWidget {
  const ScanDone({Key? key}) : super(key: key);

  @override
  State<ScanDone> createState() => _ScanDoneState();
}

class _ScanDoneState extends State<ScanDone> {
  late ColorNotifire notifire;
  // PickedFile? imageFile;

  // File? _image;
  //
  // final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getprimerycolor,
      body: SingleChildScrollView(
        child: Column(
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: notifire.getdarkscolor,
                  ),
                ),
                SizedBox(
                  width: width / 4,
                ),
                Text(
                  CustomStrings.scandone,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 40),
                ),
              ],
            ),
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  CustomStrings.addcard,
                  style: TextStyle(
                    fontSize: height / 45,
                    color: notifire.getdarkscolor,
                    fontFamily: 'Gilroy Bold',
                  ),
                )
              ],
            ),
            SizedBox(height: height / 25),
            addphoto(),
            SizedBox(height: height / 30),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  CustomStrings.fullnamee,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Medium'),
                ),
              ],
            ),
            SizedBox(height: height / 70),
            textfields("Full Name"),
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  CustomStrings.dateofbirth,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Medium'),
                ),
              ],
            ),
            SizedBox(height: height / 70),
            textfields("Birth Date"),
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  CustomStrings.nationality,
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontSize: height / 50,
                      fontFamily: 'Gilroy Medium'),
                ),
              ],
            ),
            SizedBox(height: height / 70),
            textfields("Nationality"),
            SizedBox(height: height / 10),
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
                CustomStrings.continuewiththis,
                width / 1.1,
              ),
            ),
            SizedBox(height: height / 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Setyourpin(),
                  ),
                );
              },
              child: retakebutton(
                notifire.getbluecolor,
                CustomStrings.retakephoto,
                width / 1.1,
              ),
            )
          ],
        ),
      ),
    );
  }

  retakebutton(clr, text, wid) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: clr),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        height: height / 15,
        width: wid,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: notifire.getbluecolor,
                fontSize: height / 50,
                fontFamily: 'Gilroy Medium'),
          ),
        ),
      ),
    );
  }

  Widget textfields(hinttext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 20),
      child: Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          autofocus: false,
          style: TextStyle(
            fontSize: height / 50,
            color: notifire.getdarkscolor,
          ),
          decoration: InputDecoration(
            hintText: hinttext,
            filled: true,
            fillColor: notifire.gettabwhitecolor,
            hintStyle: TextStyle(color: Colors.grey, fontSize: height / 60),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget addphoto() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // setState(() {
              //  // _openImagePicker();
              //   // _openCamera(context);
              // });
            },
            child: DottedBorder(
              strokeWidth: 2,
              dashPattern: const [5, 5],
              borderType: BorderType.RRect,
              color: notifire.getbluecolor,
              radius: const Radius.circular(20),
              child: Container(
                height: height / 6.5,
                width: width / 1.15,
                decoration: BoxDecoration(
                    color: notifire.gettabwhitecolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: height / 20),
                      Image.asset("images/AddCard.png"),
                      Text(
                        CustomStrings.addyourcard,
                        style: TextStyle(
                          fontFamily: 'GilroyMedium',
                          fontSize: height / 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
