import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final String SESSION_ID = "Poppins BlackItalic";

  static hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  Widget titleText(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Regular',
          fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black),
    );
  }

  Widget titleText1(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Regular',
          fontSize: MediaQuery.of(context).size.height * 0.02,
          color: Colors.black),
    );
  }

  Widget titleTextsemibold(text, context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins Semibold',
          fontSize: MediaQuery.of(context).size.height * 0.03,
          color: Colors.black),
    );
  }
}

