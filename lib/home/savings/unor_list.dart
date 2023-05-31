import 'package:flutter/material.dart';
import 'package:gobank/utils/media.dart';
import 'package:google_fonts/google_fonts.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      // Add space between items
      widgetList.add(SizedBox(height: 15.0));
      widgetList.add(UnorderedListItem(text));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "⭐  ",
          // textAlign: TextAlign.center,
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
