import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Auth/UI/widgets/textfield_widget.dart';
import 'package:islamic/features/Navi/UI/navi.dart';
import 'package:islamic/features/UserInfo/cubit/cubit/user_info_cubit.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  double age = 0;
  bool male = true;
  bool code = false;

  Country? pagecountry;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String city = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserInfoCubit(),
        child: BlocConsumer<UserInfoCubit, UserInfoState>(
            builder: (context, state) {
          final cubit = BlocProvider.of<UserInfoCubit>(context);
          return Scaffold(
            body: Column(
              children: [
                size.height(80),
                // profile info text
                Row(
                  children: [
                    size.width(50),
                    Text(
                      'Profile Information',
                      style: styling.maintitle.copyWith(fontSize: 28.sp),
                    ),
                  ],
                ),
                size.height(20),
                // name field
                textfieldWidget(
                  controller: nameController,
                  textfieldName: 'Name',
                  textfieldinitText: 'Enter your name',
                  textfieldIcon: null,
                  password: false,
                ),
                size.height(20),
                // phone field
                Column(
                  children: [
                    // text field title
                    Row(
                      children: [
                        size.width(30),
                        Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: colorsClass.text,
                              fontFamily: 'Manrope'),
                        ),
                      ],
                    ),
                    size.height(10),
                    // phone field
                    Container(
                      width: 300.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        // color: Color(0xfff3f4f6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child:
                            // two fields for phone and code
                            Row(
                          children: [
                            code == false
                                ? IconButton(
                                    color: colorsClass.primary,
                                    onPressed: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                            true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          setState(() {
                                            pagecountry = country;
                                            code = true;
                                            cubit.getCities(
                                                pagecountry!.name.toString());
                                          });
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.flag,
                                        color: colorsClass.text))
                                : GestureDetector(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                            true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          setState(() {
                                            pagecountry = country;
                                            cubit.getCities(
                                                pagecountry!.name.toString());
                                          });
                                        },
                                      );
                                    },
                                    child: Text(
                                      pagecountry!.flagEmoji.toString(),
                                      style: styling.subtitle,
                                    )),
                            size.width(12),
                            // phone field
                            code == false
                                ? size.width(3)
                                : state is GetcitiesLoaded
                                    ? Container(
                                        width: 80.w,
                                        height: 50.h,
                                        child: DropdownButton(
                                          value: city.isEmpty
                                              ? cubit.cities[0]
                                              : city,
                                          items: [
                                            for (int i = 0;
                                                i <= cubit.cities.length - 1;
                                                i++) ...{
                                              DropdownMenuItem(
                                                value: '${cubit.cities[i]}',
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text(
                                                      cubit.cities[i],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            }
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              city = value.toString();
                                            });
                                          },
                                        ))
                                    : size.width(15),

                            Container(
                              width: 150.w,
                              child: TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  fillColor: colorsClass.sub_background,
                                  filled: true,
                                  hintText: ' phone number',
                                  hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                      color: colorsClass.subtext,
                                      fontFamily: 'Manrope'),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: colorsClass.sub_background,
                                          width: 0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: colorsClass.sub_background,
                                          width: 0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                size.height(15),
                // age proses
                // Age text
                Row(
                  children: [
                    size.width(30),
                    Text(
                      'Age',
                      style: styling.maintitle.copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
                size.height(10),
                Row(
                  children: [
                    size.width(20),
                    Container(
                      width: 250.w,
                      child: Slider(
                        thumbColor: colorsClass.background,
                        value: age,
                        onChanged: (value) {
                          setState(() {
                            age = value;
                          });
                        },
                        min: 0,
                        max: 100,
                        activeColor: colorsClass.primary,
                        inactiveColor: colorsClass.primary.withOpacity(0.3),
                      ),
                    ),
                    size.width(10),
                    // age value
                    Text(
                      age.toStringAsFixed(0),
                      style: styling.maintitle.copyWith(fontSize: 16.sp),
                    ),
                  ],
                )
                // gender
                ,
                size.height(10),
                Row(
                  children: [
                    size.width(30),
                    Text(
                      'Gender',
                      style: styling.subtitle.copyWith(
                          fontSize: 16.sp,
                          color: colorsClass.text,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                size.height(10),
                Row(
                  children: [
                    size.width(30),
                    Container(
                      width: 180.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: colorsClass.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          size.width(5),
                          // male and female buttons
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                male = true;
                              });
                            },
                            child: Container(
                              width: 85.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: male == true
                                    ? colorsClass.background
                                    : colorsClass.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // male icon and Male text
                                  size.width(10),

                                  Icon(
                                    Icons.male,
                                    size: 23.sp,
                                    color: male == true
                                        ? colorsClass.primary
                                        : colorsClass.background,
                                  ),
                                  size.width(5),
                                  Text(
                                    'Male',
                                    style: styling.subtitle.copyWith(
                                        color: male == true
                                            ? colorsClass.primary
                                            : colorsClass.background,
                                        fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                male = false;
                              });
                            },
                            child: Container(
                              width: 85.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: male == true
                                    ? colorsClass.primary
                                    : colorsClass.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // female icon and Female text

                                  size.width(10),

                                  Icon(
                                    Icons.female,
                                    size: 23.sp,
                                    color: male == true
                                        ? colorsClass.background
                                        : colorsClass.primary,
                                  ),

                                  size.width(5),

                                  Text(
                                    'Female',
                                    style: styling.subtitle.copyWith(
                                        color: male == true
                                            ? colorsClass.background
                                            : colorsClass.primary,
                                        fontSize: 13.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )

                // save button
                ,
                size.height(50),
                GestureDetector(
                  onTap: () {
                    print('dsdad');
                    cubit.sendUserData(
                      nameController.text,
                      pagecountry!.name.toString(),
                      city,
                      phoneController.text,
                      age.round().toString(),
                      male == true ? 'Male' : 'Female',
                    );
                  },
                  child: Container(
                      width: 300.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: colorsClass.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          state is SendUserDataLoading
                              ? 'Loading...'
                              : 'Save changes',
                          style: styling.subtitle.copyWith(
                            color: colorsClass.background,
                            fontSize: 20.sp,
                          ),
                        ),
                      )),
                )
              ],
            ),
          );
        }, listener: (context, state) {
          if (state is GetcitiesLoading) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colorsClass.background,
              content: Text(
                'Loading...',
                style: styling.subtitle.copyWith(color: colorsClass.primary),
              ),
            ));
          }
          if (state is SendUserDataFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colorsClass.background,
              content: Text(
                state.failed!,
                style: styling.subtitle.copyWith(color: colorsClass.primary),
              ),
            ));
          }
          if (state is SendUserDataLoaded) {
            context.navigateTo(Navi());
          }
        }));
  }
}
