// import 'package:flutter/material.dart';
// import 'package:gobank/language/LanguageEn.dart';
// import 'package:gobank/login/register.dart';
// import 'package:gobank/login/upprofile.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../utils/button.dart';
// import '../utils/colornotifire.dart';
// import '../utils/media.dart';
// import '../utils/normaltextfild.dart';
// import '../utils/string.dart';
// import '../utils/textfeilds.dart';
//
// class AddCreditCard extends StatefulWidget {
//   const AddCreditCard({Key? key}) : super(key: key);
//
//   @override
//   State<AddCreditCard> createState() => _AddCreditCardState();
// }
//
// class _AddCreditCardState extends State<AddCreditCard> {
//   late ColorNotifire notifire;
//
//   getdarkmodepreviousstate() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? previusstate = prefs.getBool("setIsDark");
//     if (previusstate == null) {
//       notifire.setIsDark = false;
//     } else {
//       notifire.setIsDark = previusstate;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Scaffold(
//       backgroundColor: notifire.getprimerycolor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: height,
//                   width: width,
//                   color: Colors.transparent,
//                   child: Image.asset(
//                     "images/background.png",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: height / 20,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: width / 20),
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               height: height / 20,
//                               width: width / 9,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: notifire.getdarkgreycolor
//                                       .withOpacity(0.4),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(height / 150),
//                                 child: Image.asset("images/arrowleft.png"),
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             CustomStrings.addcreditcard,
//                             style: TextStyle(
//                                 color: notifire.getdarkscolor,
//                                 fontSize: height / 40,
//                                 fontFamily: 'Gilroy Bold'),
//                           ),
//                           SizedBox(width: width / 3.5)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: height / 6,
//                     ),
//                     Stack(
//                       children: [
//                         Center(
//                           child: Container(
//                             height: height / 1.2,
//                             width: width,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(40),
//                                 topLeft: Radius.circular(40),
//                               ),
//                             ),
//                             child: Column(
//                               children: [
//                                 SizedBox(height: height / 25),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: width / 20),
//                                     Text(
//                                       CustomStrings.cardinformation,
//                                       style: TextStyle(
//                                         fontSize: height / 40,
//                                         fontFamily: 'Gilroy Bold',
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(height: height / 35),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: width / 20),
//                                     Text(
//                                       CustomStrings.cardnumber,
//                                       style: TextStyle(
//                                           color: notifire.getdarkscolor,
//                                           fontSize: height / 50,
//                                           fontFamily: 'Gilroy Medium'),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: height / 70),
//                                 NornalCustomtextfilds.textField(
//                                   notifire.getdarkscolor,
//                                   notifire.getdarkgreycolor,
//                                   notifire.getbluecolor,
//                                   "XXXXXXX   XXX   XXXXXXXX",
//                                     width / 20
//                                 ),
//                                 SizedBox(height: height / 35),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: width / 20),
//                                     Text(
//                                       CustomStrings.cardholdername,
//                                       style: TextStyle(
//                                           color: notifire.getdarkscolor,
//                                           fontSize: height / 50,
//                                           fontFamily: 'Gilroy Medium'),
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: height / 70),
//                                 NornalCustomtextfilds.textField(
//                                   notifire.getdarkscolor,
//                                   notifire.getdarkgreycolor,
//                                   notifire.getbluecolor,
//                                   CustomStrings.yournamehere,
//                                     width / 20
//                                 ),
//                                 SizedBox(height: height / 35),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: width / 20),
//                                     Text(
//                                       CustomStrings.cardholdername,
//                                       style: TextStyle(
//                                           color: notifire.getdarkscolor,
//                                           fontSize: height / 50,
//                                           fontFamily: 'Gilroy Medium'),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: height / 70),
//                                 Container(color: Colors.transparent,
//                                   height: height/10,
//                                   width: width,
//                                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       NornalCustomtextfilds.textField(
//                                           notifire.getdarkscolor,
//                                           notifire.getdarkgreycolor,
//                                           notifire.getbluecolor,
//                                           CustomStrings.yournamehere,
//                                           width / 40
//                                       ),
//                                       NornalCustomtextfilds.textField(
//                                           notifire.getdarkscolor,
//                                           notifire.getdarkgreycolor,
//                                           notifire.getbluecolor,
//                                           CustomStrings.yournamehere,
//                                           width / 40
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: height / 22),
//                                 Custombutton.button(
//                                   const Color(0xffb6abfc),
//                                   CustomStrings.addcard,
//                                   width / 2,
//                                 ),
//                                 SizedBox(height: height / 15),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: width / 18),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Container(
//                                         height: height / 700,
//                                         width: width / 3,
//                                         color: Colors.grey,
//                                       ),
//                                       Text(
//                                         "or",
//                                         style: TextStyle(
//                                           color: notifire.getdarkgreycolor,
//                                           fontSize: height / 50,
//                                         ),
//                                       ),
//                                       Container(
//                                         height: height / 700,
//                                         width: width / 3,
//                                         color: Colors.grey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: height / 15),
//                                 scannerbutton(
//                                   notifire.getbluecolor,
//                                   CustomStrings.scancard,
//                                   width / 2,
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget scannerbutton(clr,text,wid){
//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(30),
//           ),
//           color: clr,
//         ),
//         height: height / 15,
//         width: wid,
//         child: Center(
//           child: Row(mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("images/Scan.png",height: height/30),
//               SizedBox(width: width/30),
//               Text(
//                 text,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: height / 50,
//                     fontFamily: 'Gilroy Medium'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
