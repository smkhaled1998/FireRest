
import 'package:firerest/category-file/category-screen.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Widget> screen = [
    const ExploreScreen(),
    MenuScreen(),
    const CartScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }


}