import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/home-layout/home-states.dart';
import 'package:firerest/models/category-model.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';
import 'package:firerest/screens/menu-screen.dart';

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

    emit(HomeChangeBottomNavBarState());
  }

  List<CategoryModel> categories = [];
  CategoryModel? categoryModel;
  void getCategory() {
    emit(HomeGettingCategoryLoadingState());
    FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((querySnapshot) {
      categories.clear();
      querySnapshot.docs.forEach((documentSnapshot) {
        categoryModel = CategoryModel.fromJson(documentSnapshot.data());
        categories.add(categoryModel!);
      });

      emit(HomeGettingCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGettingCategoryErrorState());
    });
  }
  ///*************************************

  // to pick img from mobile
  var picker = ImagePicker(); // for all
  File? categoryImg;
  Future pickCategoryImg() async {
    emit(HomePickingCategoryLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImg = File(pickedFile.path);
      emit(HomePickingCategorySuccessState());
    } else {
      print('No Image Selected');
      emit(HomePickingCategoryErrorState());
    }
  }
  ///*************************************

//to add new category >> this will be used in uploadCategoryImg

  void postCategory(
      {required String categoryName, required String categoryImg}) {
    categoryModel= CategoryModel(img:categoryImg,name:categoryName);
    FirebaseFirestore.instance
        .collection('category')
        .add(categoryModel!.toJson())
        .then((value) {
      emit(HomePostingCategorySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomePostingCategoryErrorState());
    });

  }

  void uploadCategoryImg({
    required String categoryName
  }){
    emit( HomeUploadingCategoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("category/${Uri.file(categoryImg!.path).pathSegments.last}")
        .putFile(categoryImg!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        emit(HomeUploadingCategorySuccessState());
        postCategory(
            categoryName: categoryName,
            categoryImg: value
        );
        emit(HomeDownLoadingCategorySuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(HomeDownLoadingCategoryErrorState());
      });
    }

    ).catchError((error){
      emit(HomeUploadingCategoryErrorState());
    });
  }

  ///*************************************

  void updateCategory({
    required String categoryName,
     required String categoryUpdatedName,
     String? categoryUpdatedImg,
  }){
    categoryModel =CategoryModel (
        name: categoryUpdatedName,
        img: categoryUpdatedImg
    );
    FirebaseFirestore.instance
        .collection("category")
        .where("name",isEqualTo: categoryName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      emit(HomeGettingCategorySuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("category")
            .doc(documentId)
            .update(categoryModel!.toJson())
            .then((value) {
          emit(HomeUpdatingCategorySuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(HomeUpdatingCategoryErrorState());
        });
      }
      else {
        // handle the case where there are multiple documents with the same name
        // or no documents with the specified name
      }
    });

  }
String? catImg; // this to inform that the image in not updated
  void uploadUpdatedCategoryImg({
    required String categoryName,
     String? categoryUpdatedName,
     String? categoryUpdatedImg,
  }){
    emit( HomeUploadingUpdatedCategoryLoadingState());
    // if (categoryUpdatedImg!="${categories.img}")
      firebase_storage.FirebaseStorage.instance
        .ref()
        .child("category/${Uri.file(categoryImg!.path).pathSegments.last}")
        .putFile(categoryImg!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        emit(HomeUploadingUpdatedCategorySuccessState());
        catImg=value;
          updateCategory(
            categoryName:categoryName,
            categoryUpdatedImg: value,
            categoryUpdatedName: categoryUpdatedName ?? "khaled"
        );

        // if(value.isEmpty) {
        //   updateCategory(
        //       categoryName: categoryName,
        //       categoryUpdatedImg: categoryUpdatedImg,
        //       categoryUpdatedName: categoryUpdatedName
        //   );
        // }
        emit(HomeDownLoadingUpdatedCategorySuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(HomeDownLoadingCategoryErrorState());
      });
    }

    ).catchError((error){
      emit(HomeUploadingUpdatedCategoryErrorState());
    });
  }




  ///*************************************

  void removeCategory({
    required String categoryName,
  }){

    FirebaseFirestore.instance
        .collection("category")
        .where("name",isEqualTo: categoryName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      emit(HomeGettingCategorySuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("category")
            .doc(documentId)
            .delete()
            .then((value) {
          emit(HomeDeleteCategorySuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(HomeDeleteCategoryErrorState());
        });
      }
      else {
        // handle the case where there are multiple documents with the same name
        // or no documents with the specified name
      }
    });

  }

}