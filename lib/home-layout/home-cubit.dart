import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/models/category-model.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';
import 'package:firerest/screens/menu-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());

  static HomeCubit get(context)=>BlocProvider.of(context);
  List <Widget> screen =[
    ExploreScreen(),
    MenuScreen(),
    CartScreen(),
  ];

  int currentIndex=0;
  void changeBottomNavBar(int index){
    currentIndex=index;
    print(currentIndex);
    emit(HomeChangeBottomNavBarState());
  }

  List<CategoryModel> categories = [];
  void getCategory() {
    emit(HomeGettingCategoryLoadingState());
    FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((querySnapshot) {

      querySnapshot.docs.forEach((documentSnapshot) {
        CategoryModel category = CategoryModel.fromJson(documentSnapshot.data());
        categories.add(category);
      });

      emit(HomeGettingCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGettingCategoryErrorState());
    });
  }

  // void getCategory(){
  //   emit(HomeGettingCategoryLoadingState());
  //   FirebaseFirestore.instance
  //       .collection("category")
  //       .get()
  //       .then((value) {
  //         categoryModel=CategoryModel.fromJson(value.docs);
  //   });
  // }
  // void getCategory() {
  //   emit(HomeGettingCategoryLoadingState());
  //   FirebaseFirestore.instance
  //       .collection("category")
  //       .doc("1VFU3fFZ9TYQh7fVY1nw")
  //       .get()
  //       .then((value) {
  //     categoryModel=CategoryModel.fromJson(value.data()!);
  //
  //     emit(HomeGettingCategorySuccessState());
  //   })
  //       .catchError((error) {
  //         print(error.toString());
  //     emit(HomeGettingCategoryErrorState());
  //   });
  // }
}