import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:path_provider/path_provider.dart';

class Message_sender extends StatefulWidget {
  Message_sender({super.key, required this.chatid});
  String chatid;

  @override
  State<Message_sender> createState() => _Message_senderState();
}

class _Message_senderState extends State<Message_sender> {
  TextEditingController controler =TextEditingController();
  final record =AudioRecorder();
  bool isRecording = false;
  String path = "";


 start_record() async {
  //! var location to record my voice in specific path so upload it when needed
    final location = await getApplicationDocumentsDirectory();
    if (await record.hasPermission()) {
      // Start recording to file
      await record.start(const RecordConfig(),
          path: location.path + Uuid().v4() + 'm4a');
      setState(() {
        isRecording = true;
      });
    }
  }

  stop_record() async {
    String? basepath = await record.stop();
    setState(() {
      path = basepath!;
      isRecording = false;
    });
    firebase_chats.uploadAudio(widget.chatid, path, "voice record");
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.sizeOf(context).width,
        height: 60.h,
        margin: EdgeInsets.only(left: 40.w , right: 13.w),
        decoration: BoxDecoration(color: colorsClass.background,
        borderRadius: BorderRadius.circular(20.r),
                   ),
                   child: Padding(padding: EdgeInsets.only( left: 10.0 ,top: 10),
                   child: Row(children: [
                    GestureDetector(
                  onTap: () {
                    WoltModalSheet.show<void>(
                      // pageIndexNotifier: pageIndexNotifier,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        return [
                          WoltModalSheetPage(
                            backgroundColor: colorsClass.backbackground,
                            child: Container(
                              height: 200.h,
                              child: Column(
                                children: [
                                  size.height(10),
                                  // take photo
                                  GestureDetector(
                                    onTap: () {
                                      firebase_chats.takeanduploadimage(widget.chatid!,true);
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.camera_alt_outlined,
                                          size: 25.sp, color: colorsClass.text),
                                      title: Text('Take photo',
                                          style: styling.subtitle.copyWith(
                                              fontSize: 15.sp,
                                              color: colorsClass.text,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  size.height(10),
                                  // upload photo
                                  GestureDetector(
                                    onTap: () {
                                      firebase_chats.takeanduploadimage(widget.chatid,false);

                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.image,
                                          size: 25.sp, color: colorsClass.text),
                                      title: Text('Upload image',
                                          style: styling.subtitle.copyWith(
                                              fontSize: 15.sp,
                                              color: colorsClass.text,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  size.height(10),
                                  // upload video
                                  GestureDetector(
                                    onTap: () {
                                      firebase_chats.uploadvideo(widget.chatid);
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.video_collection,
                                          size: 25.sp, color: colorsClass.text),
                                      title: Text('Upload video',
                                          style: styling.subtitle.copyWith(
                                              fontSize: 15.sp,
                                              color: colorsClass.text,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                    );
                  },
                  child: Icon(Icons.add_circle_outline,
                      size: 25.sp, color: colorsClass.text)),
                    size.width(10),
                    Container(
                      
                      width:MediaQuery.sizeOf(context).width *0.5 ,
                      child: TextField(
                        controller: controler,
                        decoration: InputDecoration(
                          hintText:'Type Message',
                          hintStyle: styling.subtitle.copyWith(color: colorsClass.subtext),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    size.width(3),
                      GestureDetector(
                  onTap: () {
                    if (isRecording == false) {
                      start_record();
                    } else {
                      stop_record();
                    }
                  },
                  child: Icon(isRecording ? Icons.stop : Icons.mic,
                      size: 20.sp, color: colorsClass.text)),
                    size.width(20.w),
                     GestureDetector(
                      onTap: () {
                        firebase_chats.sendmassage(widget.chatid, controler.text,'text');
                        controler.clear();

                      },
                      child: Icon(Icons.send , color: colorsClass.primary,)),
                  

                   ],),),
                   );
  }
}