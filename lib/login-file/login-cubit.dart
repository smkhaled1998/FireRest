import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login-states.dart';


class LoginCubit extends Cubit<LoginState>{

  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isSeen=true;
  void changeVisibility(){
    isSeen=!isSeen;
    print("$isSeen");
    emit(VisibilityState());
  }

  void userLogin({
  required String email,
    required String password
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());

    });
  }



}