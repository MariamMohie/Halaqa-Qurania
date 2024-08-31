import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Home/UI/widgets/Live_Members.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';
import 'package:islamic/features/chat/UI/screens/chats_inside.dart';
import 'package:islamic/features/chat/UI/widgets/active_members.dart';
import 'package:islamic/features/chat/cubit/cubit/chat_cubit.dart';
import 'package:islamic/features/videoCall/UI/screens/VedioSdk/Screens/joinMeeting.dart';
import 'package:islamic/features/videoCall/UI/widgets/new_stream.dart';
import 'package:islamic/features/videoCall/UI/widgets/stream_card.dart';
import 'package:islamic/features/videoCall/data/firebase_stream.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';

class StreamsScreen extends StatefulWidget {
  const StreamsScreen({super.key});

  @override
  State<StreamsScreen> createState() => _StreamsScreenState();
}

class _StreamsScreenState extends State<StreamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsClass.backbackground,
      body:  SingleChildScrollView(child: Column(
      children: [
        size.height(40.h),
        //! Row  includes Stream Text and add ion
      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Streams',
                          style: styling.maintitle.copyWith(
                              fontSize: 25.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                       Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 20.h),
                  child: GestureDetector(
                    onTap: () {
                      WoltModalSheet.show<void>(
                        // pageIndexNotifier: pageIndexNotifier,
                        context: context,
                        pageListBuilder: (modalSheetContext) {
                          return [
                            WoltModalSheetPage(
                              backgroundColor: colorsClass.backbackground,
                              child: newStream(),
                            ),
                          ];
                        },
                      );
                    },
                    child: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30.sp,
                      color: colorsClass.text,
                    ),
                  ),
                ),
              ],
            ),
                      
                    
                size.height(10.h),
                //! live members
             

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
                          size.height(20.h),
                           //! search bar
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                       // cubit.searchbyname(value);
                      },
                      decoration: InputDecoration(
                          hintText: 'searsh',
                          filled: true,
                          fillColor: colorsClass.background,
                          prefixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: colorsClass.sub_background,
                                  width: 0))),
                    ),
                  ),
                
               
                StreamBuilder(
              stream:firebase_stream.getstreams(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(color:colorsClass.primary),);
                }else{
                  return   Padding(
              padding: const EdgeInsets.all(8.0),
              child:
               GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                     context.navigateTo(JoinScreen(streamname: "",id:snapshot.data!.docs[index]['streamid'],join:true));
                    },
                    child: streamcard(
                      username: snapshot.data!.docs[index]['username'],
                      userimage: snapshot.data!.docs[index]['userimage'],
                      streamtitle: snapshot.data!.docs[index]['streamname'],
                      streamimage: snapshot.data!.docs[index]['streamimage'],
                      countrycity: snapshot.data!.docs[index]['userlocation'],
                      viewers: snapshot.data!.docs[index]['viewers'],
                      // username: "Gourge", userimage: "https://img.freepik.com/free-photo/handsome-sensitive-red-head-man-smiling_23-2149509820.jpg?ga=GA1.1.1454705726.1706974768&semt=ais_hybrid", countrycity: "Egypt,cairo", streamtitle: "Flutter", streamimage: "https://img.freepik.com/free-photo/representations-user-experience-interface-design_23-2150104476.jpg?ga=GA1.1.1454705726.1706974768&semt=ais_hybrid", viewers: 356
                    ),
                  );
                },
              ),
            );
         
               }
             }
             ),
    ],
    ),
    ),
    )
   ;
  }
}