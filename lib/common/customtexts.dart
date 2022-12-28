import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buttontext({required String buttontext}) {
  return Text(
    buttontext,
    style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget customtext(
    {required String buttontext,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    String fontfailmy = '',
    Color color = Colors.black}) {
  return Text(
    buttontext,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: fontfailmy,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
