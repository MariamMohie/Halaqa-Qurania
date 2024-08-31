import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/features/Home/data/Network/network.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/quraan.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Map<String, String>Adan={};
    ayahModel ayah = ayahModel();

void getAdanTime(String city ,String country)async{
  emit(AdanLoading());
    Adan = await getAdan(city, country);
 emit(AdanLoaded());
}
void getAyah() async {
    emit(AyahLoading());
    ayah = await getayah();
    emit(AyahLoaded());
  }

  // void changeMood() {
  //   emit(lightmoodLoading());
  //   if (localdata.hasData("mood")) {
  //     if (localdata.getbool("mood") == true) {
  //       colorsClass.primary = Color(0xff4dc9a4);
  //       colors.background = Color(0xff000000);
  //       colors.backbackground = Color.fromARGB(255, 23, 23, 23);
  //       colors.sub_background = Color(0xff7f7f7f);
  //       colors.text = Color(0xFFFFFFFF);
  //       colors.subtext = Color(0xff9095a1);
  //     } else {
  //       colors.primary = Color(0xff4dc9a4);
  //       colors.background = Color(0xFFFFFFFF);
  //       colors.backbackground = Color(0xffeaeef0);
  //       colors.sub_background = Color(0xfff3f4f6);
  //       colors.text = Color(0xff000000);
  //       colors.subtext = Color(0xff9095a1);
  //     }
  //   }else{
  //       colors.primary = Color(0xff4dc9a4);
  //       colors.background = Color(0xFFFFFFFF);
  //       colors.backbackground = Color(0xffeaeef0);
  //       colors.sub_background = Color(0xfff3f4f6);
  //       colors.text = Color(0xff000000);
  //       colors.subtext = Color(0xff9095a1);

  //   }

  //   emit(lightmoodLoaded());
  // }
}
