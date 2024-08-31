import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';

class textfieldWidget extends StatelessWidget {
  textfieldWidget({
    super.key,
    required this.textfieldName,
    required this.textfieldIcon,
    required this.textfieldinitText,
    required this.password,
    required this.controller
  });

  String? textfieldName;
  Icon? textfieldIcon;
  String? textfieldinitText;
  bool? password;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            size.width(30),
            Text(
              textfieldName!,
              style: styling.subtitle,
            ),
          ],
        ),
        Container(
          width: 320.w,
          height: 50.h,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 240, 240),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: textfieldinitText!,
                  icon: textfieldIcon,
                  suffixIcon: password!
                      ? Icon(Icons.visibility_off, color: colorsClass.text)
                      : null,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: colorsClass.sub_background, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: colorsClass.sub_background, width: 0))),
              obscureText: password == true ? true : false,
            ),
          ),
        )
      ],
    );
  }
}
