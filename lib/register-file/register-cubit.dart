import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firerest/models/user-model.dart';
import 'package:firerest/register-file/register-states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,

  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          userCreate(
              email: email,
              uId: value.user!.uid,
              phone: phone,
              name: name);
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }


  UserModel? userModel;
  void userCreate({
    required String email,
    required String uId,
    required String phone,
    required String name,
}){
    userModel=UserModel(
        name: name,
        uId: uId,
        phone: phone,
        email: email
    );
    emit(RegisterCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel!.toMap())
    .then((value){
      emit(RegisterCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RegisterCreateUserErrorState());
    });

  }
}


