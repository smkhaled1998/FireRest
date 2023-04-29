import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/menu-file/menu-states.dart';
import 'package:firerest/models/category-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MenuCubit extends Cubit<MenuStates> {
  MenuCubit() : super(MenuInitialState());

  static MenuCubit get(context) => BlocProvider.of(context);


  List<CategoryModel> categories = [];
  CategoryModel? category;
  void getCategory() {
    emit(MenuGettingCategoryLoadingState());
    FirebaseFirestore.instance
        .collection("category")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        category = CategoryModel.fromJson(documentSnapshot.data());
        categories.add(category!);
      });

      emit(MenuGettingCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(MenuGettingCategoryErrorState());
    });
  }

  void postCategory(
      {required String categoryName, required String categoryImg}) {
    category= CategoryModel(img:categoryImg,name:categoryName);
    FirebaseFirestore.instance
        .collection('category')
        .add(category!.toJson())
        .then((value) {
      emit(MenuPostingCategorySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(MenuPostingCategoryErrorState());
    });

  }

  var picker = ImagePicker(); // for all
  File? categoryImg;
  Future pickCategoryImage() async {
    emit(MenuPickingCategoryLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImg = File(pickedFile.path);
      emit(MenuPickingCategorySuccessState());
    } else {
      print('No Image Selected');
      emit(MenuPickingCategoryErrorState());
    }
  }

  void uploadCategoryImg({
    required String categoryName
  }){
    emit( MenuUploadingCategoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("category/${Uri.file(categoryImg!.path).pathSegments.last}")
        .putFile(categoryImg!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        emit(MenuUploadingCategorySuccessState());
        postCategory(
            categoryName: categoryName,
            categoryImg: value
        );
        emit(MenuDownLoadingCategorySuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(MenuDownLoadingCategoryErrorState());
      });
    }

    ).catchError((error){
      emit(MenuUploadingCategoryErrorState());
    });
  }


}
