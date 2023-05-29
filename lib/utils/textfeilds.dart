import 'package:flutter/material.dart';

import 'media.dart';

class Customtextfilds {
  static Widget textField(
      textclr,hintclr,borderclr,img,hinttext,fillcolor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 18),
      child: Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          autofocus: false,
          style: TextStyle(fontSize: height / 50, color:textclr,),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillcolor,
            hintText: hinttext,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: height / 100,horizontal: height / 70),
              child: Image.asset(img,height: height / 30,),
            ),
            hintStyle: TextStyle(color: hintclr,fontSize: height / 60),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderclr),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4),),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}