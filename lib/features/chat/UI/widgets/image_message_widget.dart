import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:video_player/video_player.dart';

class image_massage extends StatefulWidget {
  image_massage(
      {super.key,
      required this.username,
      required this.time,
      required this.messageUrl,
      required this.seen,
      required this.isSender,
      required this.isvideo
      });

  String? username;
  String? time;
  String? messageUrl;
  bool? seen;
  bool? isSender;
  bool? isvideo;

  @override
  State<image_massage> createState() => _image_massageState();
}

class _image_massageState extends State<image_massage> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      // autoPlay: true,
      allowFullScreen: true,
      autoInitialize: true,
      showControls: true,
      showOptions: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.5,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: widget.isSender == true ? colorsClass.background : colorsClass.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: widget.isSender == true
              ? Radius.circular(20)
              : Radius.circular(0),
          bottomRight: widget.isSender == true
              ? Radius.circular(0)
              : Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          size.height(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // username
              Text(
                widget.username!,
                style: styling.subtitle
                    .copyWith(color: colorsClass.text, fontSize: 10.sp),
              ),
              size.width(10.w),
              // time
              Text(
                widget.time!,
                style: styling.subtitle
                    .copyWith(color: colorsClass.text, fontSize: 10.sp),
              ),
              // seen icon
              Icon(
                widget.seen == true ? Icons.done_all : Icons.done,
                size: 15.sp,
                color:  widget.seen==true? colorsClass.primary: colorsClass.text,
              ),
            ],
          ),
          size.height(5.h),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.5,
            height: 150.h,
            decoration: widget.isvideo==true?BoxDecoration() :BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.messageUrl!), fit: BoxFit.cover)),
         child: widget.isvideo==true?AspectRatio(
            aspectRatio: 16/9,
            child: Chewie(controller: _chewieController,)):null
          ),
          
        ],
      ),
    );
  }
}