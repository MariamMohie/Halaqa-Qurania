import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:islamic/features/Auth/UI/screens/signUp.dart';
import 'package:islamic/features/Auth/UI/screens/signin.dart';
import 'package:islamic/features/Navi/UI/navi.dart';
import 'package:islamic/features/videoCall/UI/screens/VedioSdk/Screens/joinMeeting.dart';
import 'package:islamic/firebase_options.dart';


void main()async {
   await GetStorage.init();
   runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);
 WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
     FirebaseAuth.instance.currentUser==null? SignUpScreen(): Navi()
     //JoinScreen(streamname: 'Mariam', id: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo', join:false,)  //Navi()
    //SignInScreen()
      ),

    );

  }
}


