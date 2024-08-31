import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/widgets/zekr_widget.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/Doaa_model.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/tasabeh.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/zekr_model.dart';

class DoaaScreen extends StatefulWidget {
  const DoaaScreen({super.key});

  @override
  State<DoaaScreen> createState() => _DoaaScreenState();
}

class _DoaaScreenState extends State<DoaaScreen> {
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
                'Doaa',
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
                      itemCount: DoaaCategoriesList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                           
                              cubit.changeCategoryOfDoaa(index);
                             
                              
                            },
                            child: Container(
                              width: 120.h,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color:cubit.cat_index_doaa == index
                                    ? colorsClass.primary
                                    : colorsClass.background,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DoaaCategoriesList[index],
                                    style: styling.subtitle.copyWith(
                                        color: cubit.cat_index_doaa == index
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
                        itemCount:cubit.Doaatest.length,
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
                                    description:cubit.Doaatest[index].description,
                                    content:cubit. Doaatest[index].content,
                                    count:cubit. Doaatest[index].count,
                                    reference: cubit.Doaatest[index].reference),
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