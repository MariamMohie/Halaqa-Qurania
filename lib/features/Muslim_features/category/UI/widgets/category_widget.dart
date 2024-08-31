import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({
    super.key,
    required this.name,
    required this.imagePath,
  });
  String? name;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
   
            return Container(
              decoration: BoxDecoration(
                color: colorsClass.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  size.height(5),
                  Image(
                    image: AssetImage(imagePath!),
                    width: 80,
                    height: 80,
                  ),
                  size.height(5),
                  Text(
                    name!,
                    style: styling.subtitle.copyWith(
                        fontSize: 20.sp,
                        color: colorsClass.primary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
       
    
  }
}
