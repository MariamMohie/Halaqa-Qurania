import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Home/UI/widgets/header_Name+Icon.dart';
import 'package:islamic/features/Home/data/Models/home_widget_model.dart';
import 'package:islamic/features/Muslim_features/category/UI/widgets/category_widget.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/tasabeh.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsClass.backbackground,
      body: SingleChildScrollView(
        child: Column(children: [
          size.height(45),
          HeaderNameAndIcon(),
         Container(
      height: 500.h,
      child: GridView.builder(
          itemCount: HomeWidgetModel_list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5),
          itemBuilder: (context, index) {
             return GestureDetector(
              onTap: (){
                context.navigateTo(muslim_features[index]);
              },
               child: CategoryWidget(
                name: HomeWidgetModel_list[index].name, 
                imagePath: HomeWidgetModel_list[index].imagePath),
             );
          }))


        ],),
      ),
    );
  }
}