// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// import '../main.dart';
// // import 'package:plant_flutter/main.dart';
// // import 'package:plant_flutter/utils/colors.dart';
//
// class LanguageScreen extends StatefulWidget {
//   @override
//   State<LanguageScreen> createState() => _LanguageScreenState();
// }
//
// class _LanguageScreenState extends State<LanguageScreen> {
//
//   Color? getSelectedColor(BuildContext context, LanguageDataModel data) {
//     if (getStringAsync(SELECTED_LANGUAGE_CODE) == data.languageCode.validate()) {
//       return Colors.white54;
//     } else if (getStringAsync(SELECTED_LANGUAGE_CODE) == data.languageCode.validate()) {
//       return Colors.pink;
//     } else {
//       return context.cardColor;
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      // appBar: appBarWidget(language.language, textColor: Colors.white,backWidget: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => finish(context))),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           children: List.generate(localeLanguageList.length, (index) {
//             LanguageDataModel data = localeLanguageList[index];
//
//             return Container(
//               decoration: boxDecorationDefault(color: getSelectedColor(context, data), border: Border.all(color: context.dividerColor)),
//               width: context.width() / 2 - 24,
//               padding: EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('${data.name.validate()}', style: boldTextStyle()),
//                       8.height,
//                       Text('${data.subTitle.validate()}', style: secondaryTextStyle()),
//                     ],
//                   ).expand(),
//                   Image.asset(data.flag.validate(), width: 34),
//                 ],
//               ),
//             ).onTap(
//                   () async {
//                 setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
//                 selectedLanguageDataModel = data;
//                // appStore.setLanguage(data.languageCode!, context: context);
//                 setState(() {});
//               },
//               borderRadius: radius(defaultRadius),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
