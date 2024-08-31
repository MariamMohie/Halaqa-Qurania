import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/chat/UI/screens/profile.dart';
import 'package:islamic/features/chat/UI/widgets/image_message_widget.dart';
import 'package:islamic/features/chat/UI/widgets/message_sender.dart';
import 'package:islamic/features/chat/UI/widgets/text_message_widget.dart';
import 'package:islamic/features/chat/UI/widgets/voice_message.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';

class ChatsInside extends StatefulWidget {
   ChatsInside(
      {super.key,
      required this.chatid,
      required this.userid,
      required this.username,
      required this.userimage});
  String? chatid;
  String? userid;
  String? username;
  String? userimage;

  @override
  State<ChatsInside> createState() => _ChatsInsideState();
}

class _ChatsInsideState extends State<ChatsInside> {
  String lastseen = "Last seen ";

  void getlastseen() async {
    String baselastseen = await firebase_chats.getLastseen(widget.userid!);
    print(baselastseen);
    setState(() {
      lastseen = baselastseen;
      print(lastseen);
    });
  }
  void markSeen() async {
    await firebase_chats.markSeen(widget.chatid!, widget.userid!);
  }
  @override
  void initState() {
    super.initState();
    getlastseen();
   markSeen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsClass.backbackground,
      floatingActionButton: Message_sender(chatid: widget.chatid!,),
      body: Column(
        children: [
          size.height(50),
          Row(
            children: [
              size.width(10.w),
              GestureDetector(
                  onTap: () => context.goBack(),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  )),
              size.width(5.w),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userimage!),
                backgroundColor: colorsClass.primary,
              ),
              size.width(10.w),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => context.navigateTo(profile(chatid: widget.chatid!, userid: widget.userid!)),
                    child: Text(
                      widget.username!,
                      style:
                          styling.subtitle.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                 'last seen at ${lastseen.toString()}'  ,
                    style: styling.subtitle
                        .copyWith(color: colorsClass.subtext, fontSize: 12.sp),
                  ),
                ],
              ),
              size.width(90.w),
              Icon(
                CupertinoIcons.phone,
                size: 26,
                color: colorsClass.primary,
              ),
              size.width(20.w),
              Icon(
                CupertinoIcons.video_camera,
                size: 30,
                color: colorsClass.primary,
              ),
            ],
          ),
        Expanded(
            child: Container(
                color: colorsClass.backbackground,
                child: StreamBuilder(
                  stream: firebase_chats.getmassages(widget.chatid!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: colorsClass.primary),
                      );
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                size.height(10.h),
                                Row(
                                  mainAxisAlignment:snapshot.data!.docs[index]['senderid']==
                                  firebase_chats.getcurrentuserid()? MainAxisAlignment.end: MainAxisAlignment.start,
                                  children: [
                                    snapshot.data!.docs[index]['type']=="text"?
                                      GestureDetector(
                                        onLongPress: () {
                                          firebase_chats.deletemassage(widget.chatid!, snapshot.data!.docs[index].id);
                                        },
                                        child: text_massage(
                                          username: snapshot.data!.docs[index]['sendername'],
                                          time: snapshot.data!.docs[index]['time'],
                                          message: snapshot.data!.docs[index]['massage'],
                                          seen: snapshot.data!.docs[index]['seen'],
                                          isSender: snapshot.data!.docs[index]['senderid']==firebase_chats.getcurrentuserid()? true: false,
                                        ),
                                      ):
                                    snapshot.data!.docs[index]['type']=="image"?
                                    GestureDetector(
                                       onLongPress: () {
                                          firebase_chats.deletemassage(widget.chatid!, snapshot.data!.docs[index].id);
                                        },
                                      child: image_massage(
                                          username: snapshot.data!.docs[index]['sendername'],
                                          time: snapshot.data!.docs[index]['time'],
                                          messageUrl: snapshot.data!.docs[index]['massage'],
                                          seen: snapshot.data!.docs[index]['seen'],
                                          isSender: snapshot.data!.docs[index]['senderid']==firebase_chats.getcurrentuserid()? true: false,
                                          isvideo: false),
                                    )
                                        :GestureDetector(
                                           onLongPress: () {
                                          firebase_chats.deletemassage(widget.chatid!, snapshot.data!.docs[index].id);
                                        },
                                          child: voice_massage(
                                          username: snapshot.data!.docs[index]['sendername'],
                                          time: snapshot.data!.docs[index]['time'],
                                          message: snapshot.data!.docs[index]['massage'],
                                          seen: snapshot.data!.docs[index]['seen'],
                                          isSender: snapshot.data!.docs[index]['senderid']==firebase_chats.getcurrentuserid()? true: false,
                                                                                ),
                                        )
                                  ],
                                ),
                              
                              ],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ))),
       
       size.height(80),
        ],


      ),
    );
  }
}
