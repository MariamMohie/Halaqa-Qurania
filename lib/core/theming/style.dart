import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class styling{
  static TextStyle maintitle =TextStyle(
    fontSize: 35.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black, 
    fontFamily: 'Lexend'
  );

   static TextStyle subtitle =TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 94, 91, 91), 
    fontFamily: 'Manrope'
  );
   

}
  double fontsize(int length) {
    if (length >= 80) {
      return 14.sp;
    } else if (length >= 50) {
      return 18.sp;
    } else if (length >= 30) {
      return 25.sp;
    } else {
      return 27.sp;
    }
  }
  double Doaafontsize(int length) {
    if (length >= 80) {
      return 14.sp;
    } else if (length >= 50) {
      return 23.sp;
    } else if (length >= 30) {
      return 25.sp;
    } else {
      return 27.sp;
    }
  }