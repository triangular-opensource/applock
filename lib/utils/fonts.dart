import 'package:flutter/material.dart';

class MyFont {
  title({
    double fontsize = 18,
    FontWeight fontweight = FontWeight.w700,
    double? latterSpace,
    Color? color,
  }) {
    return TextStyle(
      color: color ?? Colors.black.withOpacity(0.90),
      fontSize: fontsize,
      letterSpacing: latterSpace,
      fontWeight: fontweight,
    );
  }

  TextStyle subtitle(
      {double fontsize = 16,
      FontWeight fontweight = FontWeight.w700,
      double? latterSpace,
      Color? color}) {
    return TextStyle(
      color: color ?? Colors.white.withOpacity(0.90),
      //height: 1,
      fontSize: fontsize,
      letterSpacing: latterSpace,
      //fontFamily: "Montserrat",
      fontWeight: fontweight,
    );
  }

  TextStyle normaltext(
      {double fontsize = 14,
      FontWeight fontweight = FontWeight.w400,
      double? latterSpace,
      Color? color}) {
    return TextStyle(
      color: color ?? Colors.white.withOpacity(0.90),
      //height: 1,
      fontSize: fontsize,
      letterSpacing: latterSpace,
      //fontFamily: "Montserrat",
      fontWeight: fontweight,
    );
  }
}
