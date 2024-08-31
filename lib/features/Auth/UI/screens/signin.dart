import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Auth/UI/screens/signUp.dart';
import 'package:islamic/features/Auth/UI/widgets/buttton_widget.dart';
import 'package:islamic/features/Auth/UI/widgets/f_book&google_options.dart';
import 'package:islamic/features/Auth/UI/widgets/textfield_widget.dart';
import 'package:islamic/features/Auth/cubit/cubit/auth_cubit.dart';
import 'package:islamic/features/Home/UI/screens/homeScreen.dart';
import 'package:islamic/features/Navi/UI/navi.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController forgetemailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
        if (state is SignInLoaded) {
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
           
            
             backgroundColor: colorsClass.primary, content: Center(child: Text(state.response,style: styling.subtitle.copyWith(color:colorsClass.backbackground,fontSize: 15.sp, fontWeight: FontWeight.normal), ))));
            if (state.response == 'SignIn success') {
              context.navigateTo(Navi());
            }
          }
          if (state is ForgetPasswordLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: colorsClass.background,
                content: Text(
                  state.response,
                  style: styling.subtitle
                      .copyWith(color: colorsClass.text, fontSize: 12.sp),
                )));
          }
        },
        builder: (context, state) {
          final cubit =BlocProvider.of<AuthCubit> (context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                size.height(60),

                //!   Hello Text

                Row(
                  children: [
                    size.width(140),
                    Text(
                      'Hello',
                      style: styling.maintitle,
                    ),
                  ],
                ),
                size.height(20),

                //!  Welcome back text

                Text(
                  'Welcome back',
                  style: styling.subtitle,
                ),
                size.height(20),

                //! email textfield
                size.height(30),
                textfieldWidget(
                  controller: emailController,
                  textfieldName: 'Email',
                  textfieldIcon: Icon(
                    Icons.email_rounded,
                  ),
                  textfieldinitText: 'Enter your email',
                  password: false,
                ),
                size.height(20),
                //! password textfield
                textfieldWidget(
                  controller: passwordController,
                  textfieldName: 'Password',
                  textfieldIcon: Icon(
                    Icons.password_outlined,
                  ),
                  textfieldinitText: 'Enter your password',
                  password: true,
                ),
                //! forget Password
                TextButton(
                    onPressed: () {
                      WoltModalSheet.show<void>(
                      // pageIndexNotifier: pageIndexNotifier,
                      context: context,
                      pageListBuilder: (modalSheetContext) {
                        return [
                          WoltModalSheetPage(
                            backgroundColor: colorsClass.backbackground,
                            child: Container(
                              height: 300.h,
                              child: Column(
                                children: [
                                  size.height(20),
                                  Text('Forget Password?',
                                      style: styling.maintitle
                                          .copyWith(fontSize: 16.sp)),
                                  size.height(20),
                                  textfieldWidget(
                                    controller: forgetemailController,
                                    textfieldName: 'Email',
                                    textfieldinitText: 'Enter email',
                                    textfieldIcon: Icon(Icons.email_outlined),
                                    password: false,
                                  ),
                                  size.height(20),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.forgetPassword(
                                          forgetemailController.text);
                                    },
                                    child: Container(
                                      width: 300.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorsClass.primary),
                                      child: Center(
                                        child: Text(
                                            state is ForgetPasswordLoading
                                                ? 'Loading..'
                                                : 'Send Email',
                                            style: styling.subtitle.copyWith(
                                                color: colorsClass.background)),
                                      ),
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
                    child: Text(
                      'Forget Password ?',
                      style: TextStyle(
                          color: colorsClass.primary, fontSize: 16.sp),
                    )),
                //! SignIn Button
                GestureDetector(
                  child: ButtonWidget(
                    innerText: state is SignInLoading ? 'Loading..' : 'Sign In',
                  ),
                  onTap: () {
                    cubit.signIn(emailController.text, passwordController.text);
                  },
                ),
                size.height(10),
                //! Continue with Text
                Text(
                  "OR continue with",
                  style:
                      styling.subtitle.copyWith(fontWeight: FontWeight.normal),
                ),
                Row(
      children: [
        size.width(110),
        TextButton(onPressed: (){}, child: Icon(Icons.facebook_rounded,color: colorsClass.primary,size: 40.sp,)),
        size.width(10),
        Container(width: 2.w,height: 50.h, color: Color.fromARGB(255, 203, 202, 202),),
        size.width(15),
          GestureDetector(child: Icon(Bootstrap.google,color: colorsClass.primary,size: 35,),
          onTap: (){
            cubit.signInWithGoogle();
            
          },),
      ]  
    ),
                size.height(10),
                Row(
                  children: [
                    size.width(50),
                    Text(
                      "Don't have an account ?",
                      style: styling.subtitle.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    size.width(10),
                    GestureDetector(
                        onTap: () {
                          context.navigateTo(SignUpScreen());
                        },
                        child: Text(
                          "SignUp Now",
                          style: styling.subtitle.copyWith(
                              fontSize: 14.sp, color: colorsClass.primary),
                        )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
