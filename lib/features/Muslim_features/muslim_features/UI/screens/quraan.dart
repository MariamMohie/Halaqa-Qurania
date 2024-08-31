import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/local/local.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/playSurah.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/surah.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';

class quranlist extends StatefulWidget {
  const quranlist({super.key});

  @override
  State<quranlist> createState() => _quranlistState();
}

class _quranlistState extends State<quranlist> {
  String convertNumberToArabic(String englishNumber) {
    if (englishNumber == null || englishNumber.isEmpty) {
      return '';
    }

    Map<String, String> numberMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String arabicNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      arabicNumber += numberMap[englishNumber[i]] ?? englishNumber[i];
    }

    return arabicNumber;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MuslimCubit()..getQuranList(),
        child: BlocConsumer<MuslimCubit, MuslimState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<MuslimCubit>(context);

            return Scaffold(
              backgroundColor: colorsClass.backbackground,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    size.height(60),
                    //container for last read
                    Row(
                      children: [
                        size.width(20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: 320.w,
                          height: 180.h,
                          decoration: BoxDecoration(
                              color: colorsClass.primary,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color:
                                        Color.fromARGB(255, 80, 113, 103),
                                    blurRadius: 5,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // texts
                                  Column(
                                    children: [
                                      size.height(20),
                                      // last read
                                      Row(
                                        children: [
                                          Text(
                                            '☪ Last Read',
                                            style: styling.maintitle.copyWith(
                                                color: colorsClass.background,
                                                fontSize: 22.sp),
                                          ),
                                        ],
                                      ),
                                      size.height(25),
                                      // surah name
                                      Row(
                                        children: [
                                          Text(
                                      localdata.hasData("surahname")?localdata.getString( "surahname"):"لا يوجد سورة محفوظة",
                                            style: styling.maintitle.copyWith(
                                                color: colorsClass.text,
                                                fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                      size.height(30),
                                      // surah No
                                      Row(
                                        children: [
                                          Text(
                                            'Surah NO.1',
                                            style: styling.maintitle.copyWith(
                                                color: colorsClass.backbackground,
                                                fontSize: 13.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  size.width(5),

                                  // quran image
                                  Image(
                                    image: AssetImage('assets/images/Quran.png'),
                                    width: 130.w,
                                    height: 150.h,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        size.width(20),
                      ],
                    ),
                     // search bar
                
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                  child: TextField(
                    onChanged: (value){
                    
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsClass.background,
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: colorsClass.sub_background, width: 0)),
                    ),
                  ),
                ),
                size.height(10.h),
                    
                    //! list view.builder for the Quran list

                    state is QuranListLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: colorsClass.primary,
                            ),
                          )
                        : Container(
                            height: MediaQuery.sizeOf(context).height - 250.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cubit.quranlist.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, bottom: 10.0),
                                    child: Container(
                                      height: 90.h,
                                      decoration: BoxDecoration(
                                          color: colorsClass.background,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 80, 113, 103),
                                                blurRadius: 5,
                                                offset: Offset(0, 1))
                                          ]),
                                      child: Row(
                                        children: [
                                          size.width(10),
                                          // surah number
                                          Text(
                                            '\u06DD${convertNumberToArabic(cubit
                                                        .quranlist[index]
                                                            ['number']
                                                        .toString())}',
                                            style: styling.subtitle.copyWith(
                                                fontSize: 32.sp,
                                                color: colorsClass.primary),
                                          ),
                                          size.width(10),
                                          // surah name in arabic and english
                                          Column(
                                            children: [
                                              size.height(10),
                                              Text(
                                                cubit.quranlist[index]['name'],
                                                style: styling.subtitle
                                                    .copyWith(
                                                        fontSize: 18.sp,
                                                        color: colorsClass.text,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              size.height(2),
                                              Text(
                                                cubit.quranlist[index]
                                                    ['englishName'],
                                                style:
                                                    styling.subtitle.copyWith(
                                                  fontSize: 14.sp,
                                                  color: colorsClass.text,
                                                ),
                                              ),
                                            ],
                                          ),
                                          size.width(20),

                                          Column(
                                            children: [
                                              size.height(10),
                                              //! Two buttons for play and read in row
                                              Row(
                                                children: [
                                                  //! play button
                                                  GestureDetector(
                                                    onTap: (){
                                                      context
                                                         .navigateTo(playSuarh(id:cubit.quranlist[index]['number'],name:cubit.quranlist[index]['name'],englishname: cubit.quranlist[index]['englishName'],));
                                                   
                                                    },
                                                    child: Container(
                                                      width: 55.w,
                                                      height: 35.h,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                colorsClass.primary),
                                                        color: colorsClass.background,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                      ),
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons.play_arrow,
                                                        color: colorsClass.primary,
                                                      )),
                                                    ),
                                                  ),
                                                  size.width(10),
                                                  //! read button
                                                  GestureDetector(
                                                    onTap: () {
                                                     setState(() {
                                                        localdata.addString("surahname", "${cubit.quranlist[index]['name']}\n${cubit.quranlist[index]['englishName']}");                                       

                                                      });
                                                      context
                                                          .navigateTo(surah(id:cubit.quranlist[index]['number'],name:cubit.quranlist[index]['name'],englishname: cubit.quranlist[index]['englishName'],));
                                                    },
                                                    child: Container(
                                                      width: 55.w,
                                                      height: 35.h,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                colorsClass.primary),
                                                        color:
                                                            colorsClass.background,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons
                                                            .menu_book_outlined,
                                                        color: colorsClass.primary,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // type of the surah and its ayat count
                                              size.height(10),
                                              Row(
                                                children: [
                                                  Text(
                                                    cubit.quranlist[index]
                                                        ['revelationType'],
                                                    style: styling.subtitle
                                                        .copyWith(
                                                      fontSize: 14.sp,
                                                      color: colorsClass.text,
                                                    ),
                                                  ),
                                                  size.width(10),
                                                  Text(
                                                    'Ayahs: ' +
                                                        cubit.quranlist[index][
                                                                'numberOfAyahs']
                                                            .toString(),
                                                    style: styling.subtitle
                                                        .copyWith(
                                                      fontSize: 13.sp,
                                                      color: colorsClass.text,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                  ],
                ),
              ),
            );
          },
        ));
  }
}