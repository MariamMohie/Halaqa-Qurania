import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ChatCubit>(context);
          return Scaffold(
            backgroundColor: colorsClass.backbackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  size.height(40.h),
                  //!row includes chats text and add icon

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Chats',
                          style: styling.maintitle.copyWith(
                              fontSize: 25.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            //context.navigateTo(ChatsInside());
                          },
                          child: GestureDetector(
                            child: GestureDetector(
                              onTap: () {
                                WoltModalSheet.show<void>(
                                  // pageIndexNotifier: pageIndexNotifier,
                                  context: context,
                                  pageListBuilder: (modalSheetContext) {
                                    return [
                                      WoltModalSheetPage(
                                        backgroundColor:
                                            colorsClass.backbackground,
                                        child: Container(
                                          height: 400.h,
                                          child: Column(
                                            children: [
                                              size.height(20),
                                              Text('Start chat with Others',
                                                  style: styling.maintitle
                                                      .copyWith(
                                                          fontSize: 16.sp)),
                                              size.height(20),
                                              Container(
                                                  height: 320,
                                                  child: StreamBuilder(
                                                    stream: cubit.getallusers(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return ListView.builder(
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              leading: CircleAvatar(
                                                                  radius: 22.sp,
                                                                  backgroundImage:
                                                                      NetworkImage(snapshot
                                                                          .data!
                                                                          .docs[index]['userimage'])),
                                                              title: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ['name'],
                                                                style: styling
                                                                    .maintitle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            15.sp),
                                                              ),
                                                              subtitle: Text(
                                                                '${snapshot.data!.docs[index]['age']} years , ${snapshot.data!.docs[index]['city']} -${snapshot.data!.docs[index]['country'].toString().toUpperCase()}',
                                                                style: styling
                                                                    .subtitle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            13.sp),
                                                              ),
                                                              trailing:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  if (await firebase_chats.checkchat(snapshot
                                                                          .data!
                                                                          .docs[index]['uid']) ==
                                                                      true) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      backgroundColor:
                                                                          colorsClass
                                                                              .background,
                                                                      content:
                                                                          Text(
                                                                        'Chat Already Exist',
                                                                        style: styling
                                                                            .subtitle
                                                                            .copyWith(color: colorsClass.primary),
                                                                      ),
                                                                    ));
                                                                  } else {
                                                                    firebase_chats.createchat(
                                                                        snapshot.data!.docs[index]
                                                                            [
                                                                            'uid'],
                                                                        snapshot.data!.docs[index]
                                                                            [
                                                                            'name'],
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['userimage']);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(SnackBar(
                                                                            backgroundColor: colorsClass.background,
                                                                            content: Text(
                                                                              'Chat Created',
                                                                              style: styling.subtitle.copyWith(color: colorsClass.primary),
                                                                            )));
                                                                  }
                                                                },
                                                                child: const Icon(
                                                                    Icons
                                                                        .add_circle_outline_sharp),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                    },
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                );
                              },
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 30.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  //! Memebers Icons
                  size.height(30.h),
                  Container(
                    height: 95.h,
                    child: StreamBuilder(
                      stream: firebase_chats.getuserchats(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: colorsClass.primary),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.navigateTo(ChatsInside(
                                          chatid: snapshot.data!.docs[index]
                                              ['chatid'],
                                          userid:
                                              snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                  ? snapshot.data!.docs[index]
                                                      ['otheruserid']
                                                  : snapshot.data!.docs[index]
                                                      ['userid'],
                                          username:
                                              snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                  ? snapshot.data!.docs[index]
                                                      ['otherusername']
                                                  : snapshot.data!.docs[index]
                                                      ['username'],
                                          userimage: snapshot.data!.docs[index]
                                                      ['userid'] ==
                                                  firebase_chats.getcurrentuserid()
                                              ? snapshot.data!.docs[index]['otheruserimage']
                                              : snapshot.data!.docs[index]['userimage']));
                                    },
                                    child: ActiveMembers(
                                      image: snapshot.data!.docs[index]
                                                  ['userid'] ==
                                              firebase_chats.getcurrentuserid()
                                          ? snapshot.data!.docs[index]
                                              ['otheruserimage']
                                          : snapshot.data!.docs[index]
                                              ['userimage'],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No Chats Yet',
                                style: styling.subtitle
                                    .copyWith(color: colorsClass.text),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  //! search bar
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        cubit.searchbyname(value);
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
                  //! 1-1 chat or groups
                  size.height(20.h),

                  Row(
                    children: [
                      size.width(50.w),
                      Column(
                        children: [
                          const Icon(
                            Icons.chat_outlined,
                            color: colorsClass.primary,
                          ),
                          size.height(5),
                          const Text(
                            '1-1 chats',
                            style: TextStyle(color: colorsClass.primary),
                          ),
                          size.height(5),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: 2.h,
                            color: colorsClass.primary,
                          )
                        ],
                      ),
                      size.width(100.w),
                      Column(
                        children: [
                          const Icon(
                            Icons.group_outlined,
                            color: colorsClass.text,
                          ),
                          size.height(5),
                          const Text('Groups',
                              style: TextStyle(color: colorsClass.text)),
                          size.height(5),
                        ],
                      ),
                    ],
                  ),
                  size.height(10.h),
                  cubit.searching == ""
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          child: StreamBuilder(
                              stream: firebase_chats.getuserchats(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: colorsClass.primary,
                                    ),
                                  );
                                } else {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                context.navigateTo(ChatsInside(
                                                    chatid: snapshot.data!
                                                        .docs[index]['chatid'],
                                                    userid: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otheruserid']
                                                        : snapshot.data!.docs[index]
                                                            ['userid'],
                                                    username: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otherusername']
                                                        : snapshot.data!.docs[index]
                                                            ['username'],
                                                    userimage: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otheruserimage']
                                                        : snapshot.data!.docs[index]
                                                            ['userimage']));
                                              },
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        snapshot.data!.docs[
                                                                        index][
                                                                    'userid'] ==
                                                                firebase_chats
                                                                    .getcurrentuserid()
                                                            ? snapshot.data!
                                                                    .docs[index][
                                                                'otheruserimage']
                                                            : snapshot.data!
                                                                    .docs[index]
                                                                ['userimage'])),
                                                title: Text(
                                                  snapshot.data!.docs[index]
                                                              ['userid'] ==
                                                          firebase_chats
                                                              .getcurrentuserid()
                                                      ? snapshot
                                                              .data!.docs[index]
                                                          ['otherusername']
                                                      : snapshot
                                                              .data!.docs[index]
                                                          ['username'],
                                                  style: styling.subtitle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                subtitle: Text(
                                                  snapshot.data!.docs[index]
                                                      ['lastmassage'],
                                                  style: styling.subtitle
                                                      .copyWith(
                                                          color: colorsClass
                                                              .subtext,
                                                          fontSize: 12.sp),
                                                ),
                                                trailing: Text(
                                                  snapshot.data!.docs[index]
                                                      ['lastmassagetime'],
                                                  style: TextStyle(
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ));
                                      },
                                      itemCount: snapshot.data!.docs.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          color: colorsClass.subtext,
                                          thickness: 0.3.h,
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: colorsClass.subtext,
                                          ),
                                          size.height(10.h),
                                          const Text('No Chats Yet'),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }))
                      : SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          child: StreamBuilder(
                              stream:
                                  firebase_chats.getchatbychatid(cubit.chatid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: colorsClass.primary,
                                    ),
                                  );
                                } else {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                context.navigateTo(ChatsInside(
                                                    chatid: snapshot.data!
                                                        .docs[index]['chatid'],
                                                    userid: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otheruserid']
                                                        : snapshot.data!.docs[index]
                                                            ['userid'],
                                                    username: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otherusername']
                                                        : snapshot.data!.docs[index]
                                                            ['username'],
                                                    userimage: snapshot.data!.docs[index]['userid'] == firebase_chats.getcurrentuserid()
                                                        ? snapshot.data!.docs[index]
                                                            ['otheruserimage']
                                                        : snapshot.data!.docs[index]
                                                            ['userimage']));
                                              },
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        snapshot.data!.docs[
                                                                        index][
                                                                    'userid'] ==
                                                                firebase_chats
                                                                    .getcurrentuserid()
                                                            ? snapshot.data!
                                                                    .docs[index][
                                                                'otheruserimage']
                                                            : snapshot.data!
                                                                    .docs[index]
                                                                ['userimage'])),
                                                title: Text(
                                                  snapshot.data!.docs[index]
                                                              ['userid'] ==
                                                          firebase_chats
                                                              .getcurrentuserid()
                                                      ? snapshot
                                                              .data!.docs[index]
                                                          ['otherusername']
                                                      : snapshot
                                                              .data!.docs[index]
                                                          ['username'],
                                                  style: styling.subtitle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                subtitle: Text(
                                                  snapshot.data!.docs[index]
                                                      ['lastmassage'],
                                                  style: styling.subtitle
                                                      .copyWith(
                                                          color: colorsClass
                                                              .subtext,
                                                          fontSize: 12.sp),
                                                ),
                                                trailing: Text(
                                                  snapshot.data!.docs[index]
                                                      ['lastmassagetime'],
                                                  style: TextStyle(
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ));
                                      },
                                      itemCount: snapshot.data!.docs.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          color: colorsClass.subtext,
                                          thickness: 0.3.h,
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: colorsClass.subtext,
                                          ),
                                          size.height(10.h),
                                          const Text('No Chats Yet'),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
