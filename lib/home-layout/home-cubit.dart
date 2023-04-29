import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/menu-file/menu-screen.dart';
import 'package:firerest/models/category-model.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Widget> screen = [
    ExploreScreen(),
    MenuScreen(),
    CartScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    print(currentIndex);
    emit(HomeChangeBottomNavBarState());
  }

}