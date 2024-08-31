import 'package:bloc/bloc.dart';
import 'package:islamic/features/UserInfo/data/network.dart';
import 'package:meta/meta.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());

    List cities = [];

  // get cities

  void getCities(String country) async {
    emit(GetcitiesLoading());
    try {
      cities = await UserNetwork.getcities(country);
      emit(GetcitiesLoaded());
    } catch (e) {
      emit(GetcitiesFailed());
    }
  }
  // add user data to firebase

  void sendUserData(String name, String country, String city,
      String phonenumber, String age, String gender) {
    print("jsklda");
    if (name.isEmpty ||
        country.isEmpty ||
        city.isEmpty ||
        phonenumber.isEmpty ||
        age.isEmpty ||
        gender.isEmpty) {
      emit(SendUserDataFailed(failed: "Please fill all the fields"));
    } else {
      emit(SendUserDataLoading());
      try {
        UserNetwork.sendUserData(name, country, city, phonenumber, age, gender);
        emit(SendUserDataLoaded());
      } catch (e) {
        emit(SendUserDataFailed(failed: e.toString()));
      }
    }
  }
}
