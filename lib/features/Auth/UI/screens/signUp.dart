import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/routing/routes.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/core/theming/size.dart';
import 'package:islamic/core/theming/style.dart';
import 'package:islamic/features/Auth/UI/screens/signin.dart';
import 'package:islamic/features/Auth/UI/widgets/buttton_widget.dart';
import 'package:islamic/features/Auth/UI/widgets/f_book&google_options.dart';
import 'package:islamic/features/Auth/UI/widgets/textfield_widget.dart';
import 'package:islamic/features/Auth/cubit/cubit/auth_cubit.dart';
import 'package:islamic/features/UserInfo/UI/screens/user_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
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
        if(state is SignUpLoaded){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
           
            
             backgroundColor: colorsClass.primary, content: Center(child: Text(state.response,style: styling.subtitle.copyWith(color:colorsClass.backbackground,fontSize: 15.sp, fontWeight: FontWeight.normal), ))));
        if  (state.response == 'SignUp success') {
                  context.navigateTo(UserInfoScreen());
                } 
       }

        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AuthCubit>(context);
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
                  'Create account',
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
                //! agree for terms

                size.height(20),

                Row(children: [
                  size.width(15),
                  Checkbox(
                    onChanged: (value) {},
                    value: false,
                    checkColor: colorsClass.subtext,
                  ),
                  Text('I agree with ',
                      style: styling.subtitle
                          .copyWith(fontSize: 15.sp, color: colorsClass.text)),
                  Text('Terms & Conditions ',
                      style: styling.subtitle.copyWith(
                          fontSize: 15.sp,
                          color: colorsClass.primary,
                          fontWeight: FontWeight.bold)),
                ]),
                size.height(10),
                //! SignUp Button
                GestureDetector(
                  onTap: () {
                    cubit.signUp(emailController.text.trim(),
                        passwordController.text.trim());
                  },
                  child: ButtonWidget(
                    innerText: state is SignUpLoading? 'Loading..':'Sign Up',
                  ),
                ),
                size.height(10),
                //! Continue with Text
                Text(
                  "OR continue with",
                  style:
                      styling.subtitle.copyWith(fontWeight: FontWeight.normal),
                ),
                SingnInORUpOptions(),
                size.height(10),
                Row(
                  children: [
                    size.width(20),
                    //!You have an account already  text
                    Text(
                      "You have an account already ?",
                      style: styling.subtitle.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    size.width(8),
                    //!SignIn Now link
                    GestureDetector(
                      onTap: () {
                        context.navigateTo(SignInScreen());
                      },
                      child: Text(
                        "SignIn Now",
                        style: styling.subtitle.copyWith(
                            fontSize: 14.sp, color: colorsClass.primary),
                      ),
                    ),
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
