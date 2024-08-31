import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';

class ActiveMembers extends StatelessWidget {
  ActiveMembers({super.key, required this.image});
  String? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:10.0),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: colorsClass.background,
            backgroundImage: NetworkImage(image!),
          ),
          Positioned(
              right: 0,
              bottom: 50,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorsClass.primary),
              
              )),
        ],
      ),
    );
  }
}
