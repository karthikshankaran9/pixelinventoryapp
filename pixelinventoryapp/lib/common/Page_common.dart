import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ComponentCategory {
  programmable,
  nonprogrammable,
  allcomponents
}

Future<bool?> getFluttertoastMessage(Color bgColor, Color txtColor,
    String message, Toast length, double fontsize, ToastGravity gravity) {
  return Fluttertoast.showToast(
      backgroundColor: bgColor,
      textColor: txtColor,
      msg: message,
      gravity: gravity,
      toastLength: length,
      fontSize: fontsize);
}

Widget getCommonTextControl(String title, double fontSize, Color fontcolor) {
  return Text(
    title,
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: fontcolor,
        shadows: const [
          Shadow(color: Colors.black45, offset: Offset(1, 1), blurRadius: 5)
        ]),
  );
}

Widget getCommonTextField(TextEditingController textController,
    bool obscureText, String textString, Widget suffixIcon) {
  return TextField(
    controller: textController,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: textString,
      suffixIcon: suffixIcon,
    ),
  );
}



