import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/features/Home/UI/screens/homeScreen.dart';
import 'package:islamic/features/Muslim_features/category/UI/screens/categories_screen.dart';
import 'package:islamic/features/chat/UI/screens/chats.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';
import 'package:islamic/features/videoCall/UI/screens/streams_screen.dart';

List<Widget> screens = [
  const Home(),
  const Chats(),
  const StreamsScreen(),
  const CategoriesScreen(),
// settings(),
];

class Navi extends StatefulWidget {
  const Navi({super.key});

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  var varscreen = screens[0];
  int selector = 0;
  void selectorfun(int index) {
    setState(() {
      selector = index;
      varscreen = screens[index];
    });
  }
  @override
   void initState() {
   
    super.initState();
    firebase_chats.updateLastseen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: varscreen,
      floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 5.h, left: 30, right: 2),
          height: 70.h,
          decoration: BoxDecoration(
            color: colorsClass.background,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              size.width(28),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.home_outlined),
                    onPressed: () {
                      setState(() {
                        varscreen = screens[0];
                        selectorfun(0);
                      });
                    },
                    color: selector == 0
                        ? colorsClass.primary
                        : colorsClass.subtext,
                    iconSize: 30,
                  ),
                  size.height(1),
                  Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: selector == 0
                            ? colorsClass.primary
                            : colorsClass.background,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
              size.width(13),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.chat_bubble_2),
                    onPressed: () {
                      setState(() {
                        varscreen = screens[1];
                        selectorfun(1);
                      });
                    },
                    color: selector == 1
                        ? colorsClass.primary
                        : colorsClass.subtext,
                    iconSize: 30,
                  ),
                  size.height(1),
                  Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: selector == 1
                            ? colorsClass.primary
                            : colorsClass.background,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
              size.width(13),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.video_call_outlined),
                    onPressed: () {
                      setState(() {
                        varscreen = screens[2];
                        selectorfun(2);
                      });
                    },
                    color: selector == 2
                        ? colorsClass.primary
                        : colorsClass.subtext,
                    iconSize: 30,
                  ),
                  size.height(1),
                  Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: selector == 2
                            ? colorsClass.primary
                            : colorsClass.background,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
              size.width(13),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded),
                    onPressed: () {
                      setState(() {
                        varscreen = screens[3];
                        selectorfun(3);
                      });
                    },
                    color: selector == 3
                        ? colorsClass.primary
                        : colorsClass.subtext,
                    iconSize: 30,
                  ),
                  size.height(1),
                  Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: selector == 3
                            ? colorsClass.primary
                            : colorsClass.background,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
              size.width(13),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.person_alt_circle_fill),
                    onPressed: () {
                      setState(() {
                        varscreen = screens[4];
                        selectorfun(4);
                      });
                    },
                    color: selector == 4
                        ? colorsClass.primary
                        : colorsClass.subtext,
                    iconSize: 30,
                  ),
                  size.height(1),
                  Container(
                    height: 2.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: selector == 4
                            ? colorsClass.primary
                            : colorsClass.background,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
