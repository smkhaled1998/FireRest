import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/screens/explore-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeLayoutStates>{
  HomeCubit():super(HomeInitialState());

  static HomeCubit get(context)=>BlocProvider.of(context);
  List <Widget> screen =[
    ExploreScreen(),

  ];
}