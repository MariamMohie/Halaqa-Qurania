import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';

class ButtonWidget extends StatelessWidget {
   ButtonWidget({super.key, required this.innerText});
   String ?innerText;
  @override
  Widget build(BuildContext context) {
    
    return Container(
       width: 320.w,
      height: 40.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colorsClass.primary),
      child: Center(child: Text(innerText!,style: TextStyle(color: colorsClass.background,fontSize: 17.sp, fontWeight: FontWeight.bold),)),
    );
  }
}