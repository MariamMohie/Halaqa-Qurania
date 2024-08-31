import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';

class HomeCategories extends StatelessWidget {
  HomeCategories({
    super.key,
  required this.imagePath,
  required this.name,

  });
String ? name;
String ? imagePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.all(5.0),
    child: Container(
      width: 120.w,
      height: 100.h,
      decoration: BoxDecoration(color: colorsClass.background ,borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        size.height(10),
        Image(image: AssetImage(imagePath!),width: 80,height: 80,),
         size.height(5),
         Text(name! ,style: TextStyle(color: colorsClass.primary,fontSize: 15.sp,fontWeight: FontWeight.bold),)

      ],)
    
       ),);
                
  }
}
