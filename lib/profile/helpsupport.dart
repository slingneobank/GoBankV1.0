import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

import '../utils/colornotifire.dart';
import '../utils/media.dart';

class HelpSupport extends StatefulWidget {
  final String title;
  const HelpSupport(this.title, {Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  late ColorNotifire notifire;
  final _loremIpsum =
      "Open the GoBank app to get started and follow the\nsteps. GoBank doesn't charge a fee to create or\nmaintain your GoBank account.";
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

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
                SizedBox(
                  height: height / 20,
                ),
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
                      const Spacer(),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontFamily: 'Gilroy Bold',
                          fontSize: height / 40,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height / 1.3,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width / 20, right: width / 20, top: height / 80),
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              SizedBox(height: height / 50),
                              serarchtextField(
                                Colors.black,
                                notifire.getdarkgreycolor,
                                notifire.getbluecolor,
                                CustomStrings.search,
                              ),
                              Accordion(
                                disableScrolling: true,
                                flipRightIconIfOpen: true,
                                contentVerticalPadding: 0,
                                scrollIntoViewOfItems:
                                    ScrollIntoViewOfItems.fast,
                                contentBorderColor: Colors.transparent,
                                maxOpenSections: 1,
                                headerBackgroundColorOpened: Colors.black54,
                                headerPadding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 15),
                                children: [
                                  AccordionSection(
                                    sectionClosingHapticFeedback:
                                        SectionHapticFeedback.light,
                                    contentBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    headerBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    header: Text(
                                      'What is GoBank?',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text(_loremIpsum, style: _contentStyle),
                                    contentHorizontalPadding: 20,
                                    contentBorderWidth: 1,
                                  ),
                                  AccordionSection(
                                    flipRightIconIfOpen: true,
                                    headerBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    contentBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    header: Text(
                                      'How to use GoBank?',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text(_loremIpsum, style: _contentStyle),
                                    contentHorizontalPadding: 20,
                                    contentBorderWidth: 1,
                                  ),
                                  AccordionSection(
                                    flipRightIconIfOpen: true,
                                    headerBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    contentBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    header: Text(
                                      'Can I create my own course?',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text(_loremIpsum, style: _contentStyle),
                                    contentHorizontalPadding: 20,
                                    contentBorderWidth: 1,
                                  ),
                                  AccordionSection(
                                    flipRightIconIfOpen: true,
                                    headerBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    contentBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    header: Text(
                                      'Is GoBank free to use?',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text(_loremIpsum, style: _contentStyle),
                                    contentHorizontalPadding: 20,
                                    contentBorderWidth: 1,
                                  ),
                                  AccordionSection(
                                    flipRightIconIfOpen: true,
                                    headerBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    contentBackgroundColor:
                                        notifire.gettabwhitecolor,
                                    header: Text(
                                      'How to make offer on GoBank?',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text(_loremIpsum, style: _contentStyle),
                                    contentHorizontalPadding: 20,
                                    contentBorderWidth: 1,
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }

  Widget serarchtextField(
    textclr,
    hintclr,
    borderclr,
    hinttext,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 60),
      child: Container(
        color: Colors.transparent,
        height: height / 17,
        child: TextField(
          autofocus: false,
          style: TextStyle(
            fontSize: height / 50,
            color: textclr,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: notifire.getdarkwhitecolor,
            hintText: hinttext,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintStyle: TextStyle(color: hintclr, fontSize: height / 60),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderclr),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
