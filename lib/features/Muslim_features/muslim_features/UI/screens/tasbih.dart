import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';

import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/tasabeh.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit(),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
           final cubit =BlocProvider.of<MuslimCubit>(context);
          return Scaffold(
            backgroundColor: colorsClass.backbackground,
            appBar: AppBar(
              leading: Icon(Icons.arrow_back_ios),
              title: Text(
                'Tasbih',
                style: styling.maintitle.copyWith(
                  fontSize: 25.sp,
                ),
              ),
              centerTitle: true,
              backgroundColor: colorsClass.background,
              elevation: 0,
            ),
            body: Column(
              children: [
                size.height(30),
                Container(
                  height: 230.h,
                  //! tasbeh cards
                  child: ListView.builder(
                      itemCount: tasabeh_list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            height: 50.h,
                            width: 250.w,
                            decoration: BoxDecoration(
                                color: colorsClass.background,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Column(
                              children: [
                                size.height(20),
                                //! content Text
                                Text(
                                  tasabeh_list[index].content,
                                  style: styling.maintitle.copyWith(
                                      fontSize: fontsize(
                                          tasabeh_list[index].content.length)),
                                  textAlign: TextAlign.center,
                                ),

                                size.height(10),
                                //? description Text
                                Text(
                                  tasabeh_list[index].description,
                                  style: styling.maintitle.copyWith(
                                      fontSize: 16.sp,
                                      color: colorsClass.subtext),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ));
                      }),
                ),
                size.height(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! reset button
                    GestureDetector(
                      onTap: () {
                        cubit.resetTasbehCount();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colorsClass.background,
                        ),
                        child: Icon(
                          Icons.restart_alt_outlined,
                          color: colorsClass.primary,
                          size: 30,
                        ),
                      ),
                    ),
                    size.width(70.w),
                     //! Counter button
                    GestureDetector(
                      onTap: () {
                       cubit.increaseTasbehhCount();
                      },
                     
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: colorsClass.primary,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: colorsClass.background,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                size.height(60.h),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colorsClass.primary,
                  child: Column(
                    children: [
                      size.height(15.h),
                      Text(
                        cubit.tasbeh_count.toString(),
                        style: styling.subtitle.copyWith(
                            color: colorsClass.background, fontSize: 17.sp),
                      ),
                      Text('tasbiha',
                          style: styling.subtitle.copyWith(
                              color: colorsClass.background,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
