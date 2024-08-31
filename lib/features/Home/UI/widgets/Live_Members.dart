import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';

class LiveMembers extends StatelessWidget {
  LiveMembers({super.key, required this.image});
  String? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundColor: colorsClass.background,
          backgroundImage: NetworkImage(image!),
        ),
        Positioned(
            right: 0,
            bottom: 50,
            child: Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red),
              child: const Center(
                  child: Text(
                'Live',
                style: TextStyle(
                    color: colorsClass.background, fontWeight: FontWeight.bold),
              )),
            )),
      ],
    );
  }
}
