import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/zekr_model.dart';

class ZekrWidget extends StatefulWidget {
  ZekrWidget({super.key, required this.zekr_model});

  Zeker_model zekr_model;

  @override
  State<ZekrWidget> createState() => _ZekrWidgetState();
}

class _ZekrWidgetState extends State<ZekrWidget> {
  late int count = widget.zekr_model.count;


  @override
  Widget build(BuildContext context) {
    return 
        Column(
          children: [
            size.height(30),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(
                widget.zekr_model.content,
                style: styling.maintitle.copyWith(
                    fontSize: fontsize(widget.zekr_model.content.length),
                    color: colorsClass.text,
                    fontWeight: FontWeight.bold),
                // textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
            size.height(10),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(
                widget.zekr_model.description,
                style: styling.maintitle.copyWith(
                    fontSize: 15.sp,
                    color: colorsClass.subtext,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            size.height(30),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (count > 0) {
                    count--;
                  }
                });
              },
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor:
                    count == 0 ? colorsClass.subtext : colorsClass.primary,
                child: Text(
                  count.toString(),
                  style: styling.maintitle
                      .copyWith(fontSize: 15.sp, color: colorsClass.background),
                ),
              ),
            )
          ],
        );
  }
}
