import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/AppColors.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          //  Lottie.asset("assets/joining_lottie.json", width: 100),
          CircularProgressIndicator(
            color: Appcolors.black900,
          ),
            SizedBox(height: 20.h,),
             Text("Creating a Room",
                style: TextStyle(
                    fontSize: 20,
                    color: Appcolors.black900,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
