import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Muslim_features/muslim_features/cubit/cubit/muslim_cubit.dart';

class surah extends StatefulWidget {
  surah({super.key, required this.id, required this.name,required this.englishname});
  int? id;
  String? name;
  String? englishname;
  @override
  State<surah> createState() => _surahState();
}

class _surahState extends State<surah> {
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

  int sizefont = 18;
  bool showsettings = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MuslimCubit()..getSurah(widget.id!, 'ar'),
      child: BlocConsumer<MuslimCubit, MuslimState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<MuslimCubit>(context);
          if (state is SurahLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: colorsClass.primary,
              ),
            );
          } else {
            return Scaffold(
                bottomSheet: showsettings == false
                    ? null
                    : Container(
                        height: 400.h,
                        child: Column(
                          children: [
                            size.height(20),
                            Text('Reading Mood',
                                style: styling.maintitle
                                    .copyWith(fontSize: 16.sp)),
                            size.height(20),
                            //! read mood buttons
                            Row(
                              children: [
                                //! 3 buttons for (arabic - english - both) )
                                size.width(20),
                                //! arabic button
                                GestureDetector(
                                  onTap: () {
                                    cubit.setReadingMood('arabic', widget.id!);
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.readingmood == 'arabic'
                                            ? colorsClass.primary
                                            : colorsClass.background),
                                         
                                    child: Center(
                                      child: Text(
                                        'Arabic',
                                        style: styling.subtitle.copyWith(
                                            color: cubit.readingmood == 'arabic'
                                                ? colorsClass.background
                                                : colorsClass.text),
                                      ),
                                    ),
                                  ),
                                ),
                                size.width(10),
                                //! english button
                                GestureDetector(
                                  onTap: () {
                                    cubit.setReadingMood('english', widget.id!);
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.readingmood == 'english'
                                            ? colorsClass.primary
                                            : colorsClass.background),
                                    child: Center(
                                      child: Text(
                                        'English',
                                        style: styling.subtitle.copyWith(
                                            color:
                                                cubit.readingmood == 'english'
                                                    ? colorsClass.background
                                                    : colorsClass.text),
                                      ),
                                    ),
                                  ),
                                ),
                                size.width(10),
                                //! both button
                                GestureDetector(
                                  onTap: () {
                                    cubit.setReadingMood('both', widget.id!);
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.readingmood == 'both'
                                            ? colorsClass.primary
                                            : colorsClass.background),
                                    child: Center(
                                      child: Text(
                                        'Both',
                                        style: styling.subtitle.copyWith(
                                            color: cubit.readingmood == 'both'
                                                ? colorsClass.background
                                                : colorsClass.text),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            size.height(20),
                            //! font size
                            Text('Font Size   ${cubit.sizefont}',
                                style: styling.maintitle
                                    .copyWith(fontSize: 16.sp)),
                            size.height(10),
                            //! slider for font size
                            Slider(
                              min: 10,
                              max: 100,
                              value: cubit.sizefont.toDouble(),
                              onChanged: (value) {
                                cubit.setfontsize(value.toInt());
                              },
                              activeColor: colorsClass.primary,
                              inactiveColor: colorsClass.primary.withOpacity(0.3),
                            ),
                            size.height(20),
                            // font color
                            Text('Font Color',
                                style: styling.maintitle
                                    .copyWith(fontSize: 16.sp)),
                            size.height(10),
                            //! 3 colors in circle avatar in row
                            Row(
                              children: [
                                size.width(100),
                                //! 3 colors in circle avatar
                                //! red color
                                GestureDetector(
                                  onTap: () {
                                    cubit.setcolor(colorsClass.primary);
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: colorsClass.primary,
                                  ),
                                ),
                                size.width(10),
                                // blue color
                                GestureDetector(
                                  onTap: () {
                                    cubit.setcolor(colorsClass.text);
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: colorsClass.text,
                                  ),
                                ),
                                size.width(10),
                                //! green color
                                GestureDetector(
                                  onTap: () {
                                    cubit.setcolor(Colors.red);
                                  },
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            size.height(20),

                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showsettings = false;
                                });
                              },
                              child: Container(
                                width: 300.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorsClass.primary),
                                child: Center(
                                  child: Text('Save',
                                      style: styling.subtitle
                                          .copyWith(color: colorsClass.background)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                   cubit.readingmood=='english'?widget.englishname.toString(): widget.name.toString(),
                    style: styling.subtitle
                        .copyWith(color: colorsClass.text, fontSize: 24.sp),
                  ),
                  centerTitle: true,
                  backgroundColor: colorsClass.backbackground,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: colorsClass.text,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: colorsClass.text,
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, AppRouter.search);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: colorsClass.text,
                      ),
                      onPressed: () {
                        setState(() {
                          showsettings = !showsettings;
                        });
                      },
                    ),
                  ],
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          opacity: 0.1,
                          image: AssetImage('assets/images/back.png'),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        size.height(5),
                        widget.id == 1 || widget.id == 9
                            ? size.height(1)
                            : Text(
                                'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                style: styling.subtitle.copyWith(
                                    color: colorsClass.text, fontSize: 30.sp),
                                textAlign: TextAlign.center,
                              ),
                        size.height(15),
                     
                     cubit.readingmood=='both'?
                     Container(
                      height: MediaQuery.of(context).size.height-200.h,
                      child: ListView.separated(
                        itemCount: cubit.surah.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              size.height(15),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  cubit.surah[index]['text'].toString().replaceAll(
                                                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                    '') 
                                      ,
                                  style: styling.subtitle.copyWith(
                                      fontSize: cubit.sizefont.toDouble(),
                                      color: cubit.color,
                                      fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                ),
                              ),
                              size.height(10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                  cubit.surah2[index]['text'].toString().replaceAll(
                                                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                    '') 
                                      ,
                                  style: styling.subtitle.copyWith(
                                      fontSize: cubit.sizefont.toDouble(),
                                      color: cubit.color,
                                      //fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                                                ),
                                ),
                              size.height(15),

                            ],
                            
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: colorsClass.background,
                             
                            ),
                            child:Row(
                              children: [
                                size.width(30),
                                Text(
                                  '\u06DD' +
                                          convertNumberToArabic(cubit.surah[index]
                                                  ['numberInSurah']
                                              .toString())
                                     ,
                                  style: styling.subtitle.copyWith(
                                    fontSize: 24.sp,
                                    color: colorsClass.text,
                                  ),
                                ),
                                size.width(170),
                                IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border,color: colorsClass.text,)),
                                size.width(2),
                                IconButton(onPressed: (){}, icon: Icon(Icons.copy,color: colorsClass.text,)),



                              ],
                            ) ,
                          
                          );
                        },
                      ),
                     )
                        :RichText(
                            textAlign: TextAlign.center,
                            textDirection:  
                             cubit.readingmood=='english'?TextDirection.ltr: TextDirection.rtl,
                            text: TextSpan(
                              children: [
                              for (int i = 0; i < cubit.surah.length; i++) ...{
                                TextSpan(
                                  text: widget.id != 1
                                      ? cubit.surah[i]['text']
                                              .toString()
                                              .replaceAll(
                                                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                                                  '') +
                                          '\u06DD' +
                                          convertNumberToArabic(cubit.surah[i]
                                                  ['numberInSurah']
                                              .toString())
                                      : cubit.surah[i]['text'].toString() +
                                          '\u06DD' +
                                          convertNumberToArabic(cubit.surah[i]
                                                  ['numberInSurah']
                                              .toString()),
                                  style: styling.subtitle.copyWith(
                                      fontSize: cubit.sizefont.toDouble(),
                                      color: cubit.color,
                                      fontWeight: FontWeight.bold),
                                ),
                              }
                            ])),
                      ],
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}