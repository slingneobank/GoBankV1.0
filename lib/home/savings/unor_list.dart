import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {Key? key}) : super(key: key);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      // Add space between items
      widgetList.add(const SizedBox(height: 15.0));
      widgetList.add(UnorderedListItem(text));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
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
