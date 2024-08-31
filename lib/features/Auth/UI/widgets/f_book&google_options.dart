import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';

class SingnInORUpOptions extends StatelessWidget {
  const SingnInORUpOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        size.width(110),
        TextButton(onPressed: (){}, child: Icon(Icons.facebook_rounded,color: colorsClass.primary,size: 40.sp,)),
        size.width(10),
        Container(width: 2.w,height: 50.h, color: Color.fromARGB(255, 203, 202, 202),),
        size.width(15),
          GestureDetector(child: Icon(Bootstrap.google,color: colorsClass.primary,size: 35,),
          onTap: (){
            
          },),
      ]  
    );
  }
}