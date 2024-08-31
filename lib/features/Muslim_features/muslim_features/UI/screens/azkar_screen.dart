import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/widgets/zekr_widget.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/zekr_model.dart';

class Azkar extends StatefulWidget {
  const Azkar({super.key});

  @override
  State<Azkar> createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
 
  int counter = 0;
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
            //! app bar
            appBar: AppBar(
              leading: Icon(Icons.arrow_back_ios),
              title: Text(
                'Azkar',
                style: styling.maintitle.copyWith(
                  fontSize: 25.sp,
                ),
              ),
              centerTitle: true,
              backgroundColor: colorsClass.background,
              elevation: 0,
            ),
            backgroundColor: colorsClass.backbackground,
            body: SingleChildScrollView(
              child: Column(children: [
                size.height(30),
                //! ListView For Azkar
                Container(
                  height: 60.h,
                  child: ListView.builder(
                      itemCount: azkarCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                           
                              cubit.changeCategoryOfAzkar(index);
                             
                              
                            },
                            child: Container(
                              width: 120.h,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color:cubit.cat_index == index
                                    ? colorsClass.primary
                                    : colorsClass.background,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    azkarCategories[index],
                                    style: styling.subtitle.copyWith(
                                        color: cubit.cat_index == index
                                            ? colorsClass.backbackground
                                            : colorsClass.primary),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                size.height(15),
                //! ListView vertically for Azkar

                Container(
                    height: MediaQuery.of(context).size.height - 200.h,
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        shrinkWrap: false,
                        itemCount:cubit.test.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: 300.h,
                              decoration: BoxDecoration(
                                color: colorsClass.background,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: colorsClass.primary),
                              ),
                              child: ZekrWidget(
                                zekr_model: Zeker_model(
                                    category: ' ',
                                    description:cubit.test[index].description,
                                    content:cubit. test[index].content,
                                    count:cubit. test[index].count,
                                    reference: cubit.test[index].reference),
                              ),
                            ),
                          );
                        }))
              ]),
            ),
          );
        },
      ),
    );
  }
}
