
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter/material.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/widgets/hadith.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/hadith_model.dart';

class hadith extends StatefulWidget {
  const hadith({super.key});

  @override
  State<hadith> createState() => _hadithState();
}

class _hadithState extends State<hadith> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MuslimCubit()..getHadith("abu-dawud",0),
        child: BlocConsumer<MuslimCubit, MuslimState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<MuslimCubit>(context);

            return Scaffold(
              backgroundColor: colorsClass.backbackground,
              //AppBar
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorsClass.text,
                  ),
                  onPressed: () {
                    context.goBack();
                  },
                ),
                title: Text(
                  'Hadith',
                  style: styling.maintitle.copyWith(fontSize: 25.sp),
                ),
                centerTitle: true,
                backgroundColor: colorsClass.backbackground,
                elevation: 0,
              ),
              // body
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    size.height(15),
                    // listview horizontal for Azkar
                    Container(
                      height: 60.h,
                      child: ListView.builder(
                        itemCount: hadithcategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              cubit.getHadith(hadithcategoriesApi[index],hadithcategoriesApi.indexOf(hadithcategoriesApi[index]));
                              
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w),
                              height: 40.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: cubit.hadithindex == index
                                    ? colorsClass.primary
                                    : colorsClass.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    hadithcategories[index],
                                    style: styling.maintitle.copyWith(
                                        fontSize: 15.sp,
                                        color: cubit.hadithindex == index
                                            ? colorsClass.background
                                            : colorsClass.primary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    size.height(15),
                    // listview vertical for zekr
                    Container(
                      height: MediaQuery.of(context).size.height - 200.h,
                      child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        shrinkWrap: false,
                        itemCount: cubit.hadith.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:hadithwidget(
                              hadithtitile: cubit.hadith[index],
                            )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }
}