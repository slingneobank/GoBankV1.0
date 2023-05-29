import 'package:flutter/material.dart';

import 'media.dart';

class Customtextfild2 {
  static Widget textField(txt,name1,clr,textcolor, img, se,fbcolor,fillcolor) {
    return
     Container(
        color: Colors.transparent,
        height: height / 15,
        child: TextField(
          obscureText: txt,
          style: TextStyle(color: textcolor),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillcolor,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: height / 100,horizontal: height / 70),
              child: Image.asset(img,height: height / 30,),
            ),
            hintText: name1,
            hintStyle: TextStyle(color: clr,fontSize: height / 60),
            suffixIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: height / 50,horizontal: height / 70),
                child: se
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color: fbcolor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );

  }
}