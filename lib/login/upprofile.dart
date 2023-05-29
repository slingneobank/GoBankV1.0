// import 'package:flutter/material.dart';
// import 'package:gobank/login/addcreditcard.dart';
// import 'package:gobank/utils/colornotifire.dart';
// import 'package:gobank/utils/string.dart';
// import 'package:provider/provider.dart';
//
// import '../utils/button.dart';
// import '../utils/media.dart';
//
// class UpProfile extends StatefulWidget {
//   const UpProfile({Key? key}) : super(key: key);
//
//   @override
//   State<UpProfile> createState() => _UpProfileState();
// }
//
// class _UpProfileState extends State<UpProfile> {
//   late ColorNotifire notifire;
//
//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: height,
//             width: width,
//             color: Colors.transparent,
//             child: Image.asset(
//               "images/background.png",
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             children: [
//               SizedBox(height: height / 15),
//               Row(
//                 children: [
//                   const Spacer(),
//                   Text(
//                     CustomStrings.skip,
//                     style: TextStyle(
//                       fontSize: height / 50,
//                       fontFamily: 'Gilroy Bold',
//                     ),
//                   ),
//                   SizedBox(width: width / 20)
//                 ],
//               ),
//               SizedBox(height: height / 7.8),
//               Image.asset("images/setupprofile.png"),
//               SizedBox(height: height / 22),
//               Text(
//                 CustomStrings.addcreditionalstoloop,
//                 style:
//                     TextStyle(fontSize: height / 35, fontFamily: 'Gilroy Bold'),
//               ),
//               SizedBox(height: height / 40),
//               Text(
//                 CustomStrings.addyourbankcradite,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: height / 63,
//                   fontFamily: 'Gilroy Medium',
//                 ),
//               ),
//               SizedBox(height: height / 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AddCreditCard(),
//                     ),
//                   );
//                 },
//                 child: Custombutton.button(
//                     notifire.getbluecolor, CustomStrings.next, width / 2),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
