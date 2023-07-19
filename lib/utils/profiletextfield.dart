import 'package:flutter/material.dart';

import 'media.dart';

class Profiletextfilds {
  static Widget textField(text,
      textclr,hintclr,borderclr,hinttext,fillcolor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 18),
      child: Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          controller: TextEditingController(text: text),
          autofocus: false,
          style: TextStyle(fontSize: height / 50, color:textclr,),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillcolor,
            hintText: hinttext,
            hintStyle: TextStyle(color: hintclr,fontSize: height / 60),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderclr),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffd3d3d3)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}