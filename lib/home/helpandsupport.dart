// import 'package:flutter/material.dart';

// class SlingCard extends StatefulWidget {
//   const SlingCard({Key? key}) : super(key: key);

//   @override
//   State<SlingCard> createState() => _SlingCardState();
// }

// class _SlingCardState extends State<SlingCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Sling Card',
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.messenger_outline_rounded),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.search),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:gobank/utils/string.dart';
import 'package:provider/provider.dart';

import '../../utils/colornotifire.dart';

class HelpAndSupport extends StatefulWidget {
  //final String title;
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  late ColorNotifire notifire;
  final _loremIpsum =
      "Fyp card is a prepaid card, especially designed for teenagers. Now teens can use their own debit card for online and offline transactions without being dependent on parents. For added security, we have removed all the sensitive details from the card. So, your card number and CVV are only present in the Fyp app. How cool is that?";
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
                        //widget.title,
                        'Help And Support',
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
                  // height: height / 1,
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
                                      'What is Sling Card?',
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
                                      'Can I use my card for ATM withdrawl',
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
                                      'How can I increase my spending limit?',
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
                                      'What benefits will I get if I order a Fyp card?',
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
                                      'Where can I use Fyp card?',
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
                                      'Why there is a different expiry date on my Physical Fyp Card?',
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
                                      'How do I use the Fyp card at offline stores?',
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
                                      'How can I order Fyp card?',
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
                                      'Where is the Fyp card numberless?',
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
                                      'I ve received my Fyp card, how do I activate it?',
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
                                      'I have lost my Fyp card. How can I order a new card?',
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
                                      'How is Fyp different from a traditional debit card?',
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
