import 'package:bloc/bloc.dart';
import 'package:islamic/features/Auth/data/network.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

   // signUp function
  void signUp(String email, String password) async {
    if(email.isEmpty||password.isEmpty){
      emit(SignUpLoaded('Please fill all fields'));
    }
    emit(SignUpLoading());
    try {
     String response= await authNetwork().signUp(email, password);
      emit(SignUpLoaded(response));

    } catch (e) {
      emit(SignUpFailed());
    }
  }

  // signIn function
  void signIn(String email, String password) async {
    if(email.isEmpty||password.isEmpty){
      emit(SignInLoaded('Please fill all fields'));
    }
    emit(SignInLoading());
    try {
      String response= await authNetwork().signIn(email, password);
      emit(SignInLoaded(response));
    } catch (e) {
      emit(SignInFailed());
    }
  }

  // forget password function
  void forgetPassword(String email) async {
    if(email.isEmpty){
      emit(ForgetPasswordLoaded('Please write your email'));
    }
    emit(ForgetPasswordLoading());
    try {
      String response= await authNetwork().forgetPassword(email);
      emit(ForgetPasswordLoaded(response));
    } catch (e) {
      emit(ForgetPasswordFailed());
    }
  }
  //signIn with google function
  void signInWithGoogle() async {
    emit(SignInLoading());
    try {
       await authNetwork().signInWithGoogle();
      emit(SignInLoaded('SignIn success'));
    } catch (e) {
      emit(SignInFailed());
    }
  }


}

