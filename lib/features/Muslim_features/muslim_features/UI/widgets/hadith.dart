import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';


class hadithwidget extends StatefulWidget {
  hadithwidget({super.key, required this.hadithtitile});
  String hadithtitile;

  @override
  State<hadithwidget> createState() => _zekrState();
}

class _zekrState extends State<hadithwidget> {




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: colorsClass.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorsClass.primary, width: 2.w),
      ),
      child: Column(
        children: [
          size.height(10),
          
          Padding(
            padding:  EdgeInsets.only(right: 10.w,left: 10.w),
            child: Text(
            widget.hadithtitile,
              style: styling.maintitle.copyWith(
                  fontSize: fontsize(widget.hadithtitile.length),
                  color: colorsClass.text,
                  fontWeight: FontWeight.bold),
                 textAlign: TextAlign.center,
            ),
          ),
         
        ],
      ),
    );
  }
}
