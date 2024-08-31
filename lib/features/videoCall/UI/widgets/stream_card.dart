import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/style.dart';

class streamcard extends StatelessWidget {
   streamcard({
    super.key,
 required   this.username,
 required   this.userimage,
 required   this.countrycity,
 required   this.streamtitle,
 required   this.streamimage,
 required   this.viewers,});
  String? username;
  String? userimage;
  String? countrycity;
  String? streamtitle;
  String? streamimage;
  int? viewers;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: MediaQuery.sizeOf(context).height * 0.36,
        decoration: BoxDecoration(
          color: colorsClass.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // stream image
            Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(streamimage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // live icon
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                       height: 22.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          'Live',
                          style: styling.subtitle.copyWith(
                              color: colorsClass.background, fontSize: 10.sp),
                        ),
                      )),
                ),
                // count of viewers
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                      height: 22.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: colorsClass.text,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Center(
                        child: Text(
                          '${viewers!} 👁',
                          style: styling.subtitle.copyWith(
                              color: colorsClass.background, fontSize: 10.sp),
                        ),
                      )),
                ),
                // stream title
                Positioned(
                  bottom: 10,
                  left: 7,
                  child: Center(
                    child: Text(
                      streamtitle!,
                      style: styling.maintitle
                          .copyWith(fontSize: 14.sp, color: colorsClass.primary),
                    ),
                  ),
                ),
              ],
            ),
            // user details [image , name and country and city]
            Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                height: MediaQuery.sizeOf(context).height * 0.08,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(userimage!),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username!,
                            style:
                                styling.maintitle.copyWith(fontSize: 14.sp),
                          ),
                          Text(
                            countrycity!,
                            style: styling.subtitle.copyWith(fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}