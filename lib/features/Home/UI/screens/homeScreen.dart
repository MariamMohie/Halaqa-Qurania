import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Home/UI/widgets/Live_Members.dart';
import 'package:islamic/features/Home/UI/widgets/header_Name+Icon.dart';
import 'package:islamic/features/Home/UI/widgets/home_categories.dart';
import 'package:islamic/features/Home/cubit/cubit/home_cubit.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';
import 'package:islamic/features/Home/data/Network/network.dart';
import 'package:islamic/features/Muslim_features/muslim_features/UI/screens/surah.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/tasabeh.dart';
import 'package:islamic/features/videoCall/data/firebase_stream.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}


class _HomeState extends State<Home> {
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
      create: (context) => HomeCubit()..getAdanTime("cairo", "egypt")..getAyah(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit =BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            backgroundColor: colorsClass.backbackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(45),
                  //! user name and person icon
                  HeaderNameAndIcon(),

                  size.height(15),
                  //! prays Time
                    state is AdanLoading?
                  CircularProgressIndicator(color: colorsClass.primary,)
                  :
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 200.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/prayers_time.png'),
                            fit: BoxFit.cover)),
                            child: Column(
                              children: [
                                size.height(140),
                                Row(
                                  children: [
                                    size.width(15.w),
                                    Text(cubit.Adan["Fajr"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),)
                                   ,size.width(10.w),
                                    Text(cubit.Adan["Sunrise"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),),
                                      size.width(20.w),
                                    Text(cubit.Adan["Dhuhr"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),),
                                   size.width(10.w),
                                    Text(cubit.Adan["Asr"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),),
                                   size.width(15.w),
                                    Text(cubit.Adan["Maghrib"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),),
                                  size.width(20.w),
                                    Text(cubit.Adan["Isha"].toString(),style: styling.subtitle.copyWith(fontSize: 15.sp,color: colorsClass.primary,fontWeight: FontWeight.bold),),
                                 
                                  ],
                                )
                              ],
                            ),
                  ),
                  //! Muslim Icons

                   StreamBuilder(
                  stream: firebase_stream.getstreams(),
                 builder: ((context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: colorsClass.primary,),);
                  }else{
                    return     Container(
                      height: 100.h,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: LiveMembers(
                                    image:
                                        snapshot.data!.docs[index]['streamimage']));
                          }));
                  }
                   
                 })),

                  GestureDetector(
                    onTap: (){
                      // context.navigateTo(muslim_features[index]);
                    },
                    child: Container(
                        height: 120.h,
                        child: ListView.builder(
                            itemCount: HomeWidgetModel_list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                               
                                 onTap: () => context.navigateTo(muslim_features[index]),
                                
                                child: HomeCategories(
                                    imagePath:
                                        HomeWidgetModel_list[index].imagePath,
                                    name: HomeWidgetModel_list[index].name),
                              );
                            })),
                  ),
                                size.height(15),
        state is AyahLoaded ?          
       GestureDetector (
        onTap:(){
          context.navigateTo(surah(id:cubit.ayah.surahnumber,name:cubit.ayah.surahname,englishname: cubit.ayah.englishname,));
        },
           child: Container(
               height: 250.h,
               width: MediaQuery.sizeOf(context).width*0.9,
               decoration: BoxDecoration(
                 color: colorsClass.background,
                 borderRadius: BorderRadius.circular(10),
                 border: Border.all(color: colorsClass.primary, width: 2.w),
               ),
               child: Column(
                 children: [
            size.height(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('تدبر',
                    style: styling.maintitle.copyWith(fontSize: 22.sp)),
                size.width(10),
              
              ],
            ),
            size.height(5),
           // surah name and ayah number in row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
                Text(    '\u06DD' +
                   convertNumberToArabic(cubit.ayah.ayahnumber!.toString()).toString(),
                    style: styling.subtitle.copyWith(
                        fontSize: 17.sp,
                        color: colorsClass.text,
                        fontWeight: FontWeight.bold)),
                size.width(10),
                  Text(cubit.ayah.surahname!,
                    style: styling.subtitle.copyWith(fontSize: 17.sp)),
              ],
            ),
           
            
            Padding(
              padding:  EdgeInsets.only(right: 10.w,left: 10.w , bottom: 20),
              child: Text(
                cubit.ayah.ayah!,
                style: styling.maintitle.copyWith(
                    fontSize: fontsize(30,),
                    color: colorsClass.text,
                    fontWeight: FontWeight.bold),
                   textAlign: TextAlign.center,
              ),
            ),
            size.height(10),
            
                
                
                 ],
               ),
             ),
         ):SizedBox(),
    
    size.height(50),
    


                ],
              ),
                   
           
     
      ),
              
             
          
          );
        },
      ),
    );
  }
}
