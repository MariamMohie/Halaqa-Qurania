import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/videoCall/UI/screens/VedioSdk/Screens/joinMeeting.dart';
import 'package:islamic/features/videoCall/cubit/cubit/stream_cubit.dart';

class newStream extends StatelessWidget {
  newStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StreamCubit(),
      child: BlocConsumer<StreamCubit, StreamState>(
        listener: (context, state) {
          // Handle any specific state changes if needed
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<StreamCubit>(context);
          return Container(
            height: 400.h,
            child: Column(
              children: [
                size.height(20),
                Text('Start a new stream',
                    style: styling.maintitle.copyWith(fontSize: 16.sp)),
                size.height(20),
                //! upload stream's Image
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.uploadImage(false);
                        },
                        child: Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: colorsClass.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: state is StreamCreateLoading
                              ? CircularProgressIndicator()
                              : cubit.image_url.isNotEmpty
                                  ? Image.network(cubit.image_url, fit: BoxFit.cover)
                                  : Icon(
                                      Icons.add_a_photo,
                                      size: 50.sp,
                                      color: colorsClass.text,
                                    ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upload Stream Image',
                                style: styling.maintitle
                                    .copyWith(fontSize: 16.sp)),
                            size.height(10.h),
                            Text('Select an image or take it',
                                style: styling.maintitle
                                    .copyWith(fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                size.height(20),
                // text field for stream title
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20),
                  child: TextField(
                    controller: cubit.streamname,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsClass.background,
                      hintText: 'Stream Title',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: colorsClass.sub_background, width: 0)),
                    ),
                  ),
                ),
                size.height(20),
                //! text field for stream id
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20),
                  child: TextField(
                    controller: cubit.streamid,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorsClass.background,
                      hintText: 'Stream ID  [write 4 numbers]',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: colorsClass.sub_background, width: 0)),
                    ),
                  ),
                ),
                size.height(20),
                //! create button
                GestureDetector(
                  onTap: () {
                    if (  //cubit.image_url.isNotEmpty &&
                       cubit.streamname.text.isNotEmpty) {
                      // cubit.createStream(streamname.text, streamid.text);
                      context.navigateTo(JoinScreen(streamname:cubit.streamname.text,id:"",join:false));}},
                  
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Container(
                      height: 50.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: colorsClass.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Create',
                            style: styling.maintitle.copyWith(
                                fontSize: 16.sp, color: colorsClass.background)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
