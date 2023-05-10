import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/category-file/category-screen.dart';

import 'package:firerest/category-file/category-states.dart';
import 'package:firerest/models/category-model.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';
import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CategoryCubit extends Cubit<CategoryStates> {

  final PageController pageController = PageController();
  double currentPageValue = 0;

  List<Widget> screen = [
    const ExploreScreen(),
    MenuScreen(),
    const CartScreen(),
  ];

  int currentIndex = 0;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(CategoryChangeBottomNavBarState());
  }



  CategoryCubit() : super(CategoryInitialState());
  // {
  //   pageController.addListener(() {
  //     currentPageValue = pageController.page!;
  //     emit(CategoryInitiatePageViewState());
  //   });
  // }
  //
  // @override
  // Future<void> close() {
  //   pageController.dispose();
  //   return super.close();
  // }
  static CategoryCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> categories = [];
  CategoryModel? categoryModel;
  void getCategory() {
    emit(CategoryGettingDataLoadingState());
    FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((querySnapshot) {
      categories.clear();
      querySnapshot.docs.forEach((documentSnapshot) {
        categoryModel = CategoryModel.fromJson(documentSnapshot.data());
        categories.add(categoryModel!);
      });

      emit(CategoryGettingDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryGettingDataErrorState());
    });
  }
  ///*************************************

  // to pick img from mobile
  var picker = ImagePicker(); // for all
  File? categoryImg;
  Future pickImg() async {
    emit(CategoryPickingImgLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImg = File(pickedFile.path);
      emit(CategoryPickingImgSuccessState());
    } else {
      print('No Image Selected');
      emit(CategoryPickingImgErrorState());
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
      emit(CategoryPostingDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoryPostingDataErrorState());
    });

  }

  void uploadCategoryImg({
    required String categoryName
  }){
    emit( CategoryUploadingImgLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("category/${Uri.file(categoryImg!.path).pathSegments.last}")
        .putFile(categoryImg!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        emit(CategoryUploadingImgSuccessState());
        postCategory(
            categoryName: categoryName,
            categoryImg: value
        );
        emit(CategoryDownLoadingImgUrlSuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(CategoryDownLoadingImgUrlErrorState());
      });
    }

    ).catchError((error){
      emit(CategoryUploadingImgErrorState());
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
      emit(CategoryGettingDataSuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("category")
            .doc(documentId)
            .update(categoryModel!.toJson())
            .then((value) {
          emit(CategoryUpdatingDataSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(CategoryUpdatingDataErrorState());
        });
      }
      else {
       print("isueeeeeeeeeeeee");
      }
    });
  }

  // String? catImg; // this to inform that the image in not updated
  void uploadUpdatedCategoryImg({
    required String categoryName,
    required int index,
    String? categoryUpdatedName,
  }){
    emit( CategoryUploadingUpdatedImgLoadingState());
    if (categoryImg!=null){
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child("category/${Uri.file(categoryImg!.path).pathSegments.last}")
          .putFile(categoryImg!)
          .then((value){
        value.ref.getDownloadURL().then((value) {
          emit(CategoryUploadingUpdatedImgSuccessState());
          updateCategory(
              categoryName:categoryName,
              categoryUpdatedImg: value,
              categoryUpdatedName: categoryUpdatedName ?? "${categories[index].name}"
          );

          emit(CategoryDownLoadingUpdatedImgUrlSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(CategoryDownLoadingImgUrlErrorState());
        });
      }

      ).catchError((error){
        emit(CategoryUploadingUpdatedImgErrorState());
      });
    }else {
      updateCategory(
          categoryName:categoryName,
          categoryUpdatedName: categoryUpdatedName ?? "${categories[index].name}",
          categoryUpdatedImg: "${categories[index].img}"
      );
    }

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
      emit(CategoryGettingDataSuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("category")
            .doc(documentId)
            .delete()
            .then((value) {
          emit(CategoryDeleteDataSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(CategoryDeleteDataErrorState());
        });
      }
      else {
        // handle the case where there are multiple documents with the same name
        // or no documents with the specified name
      }
    });
  }

}