import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';


class HeaderNameAndIcon extends StatelessWidget {
  const HeaderNameAndIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                size.width(15.w),
                Text('Hello,',
                    style: styling.subtitle.copyWith(fontSize: 17.sp)),
                Text('Mariam!',
                    style: styling.subtitle.copyWith(
                        fontSize: 19.sp,
                        color: colorsClass.text,
                        fontWeight: FontWeight.bold)),
                size.width(150.w),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.person_circle,
                      size: 30.sp,
                      color: colorsClass.text,
                    )),
              ],
            );
  }
}