import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/items-file/item-states.dart';
import 'package:firerest/models/items-model.dart';
import 'package:firerest/shared/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ItemsCubit extends Cubit<ItemsStates>{

  ItemsCubit():super(ItemsInitialState());

  static ItemsCubit get(context)=>BlocProvider.of(context);

  List<ItemsModel> items = [];
  ItemsModel? itemsModel;
  void getItems({
  required String categoryId
}) {
    emit(ItemsGettingDataLoadingState());
    FirebaseFirestore.instance
        .collection("items")
        .where("categoryId",isEqualTo: categoryId)
        .get()
        .then((querySnapshot) {
      items.clear();
      querySnapshot.docs.forEach((documentSnapshot) {
        itemsModel = ItemsModel.fromJson(documentSnapshot.data());
        items.add(itemsModel!);
      });

      emit(ItemsGettingDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ItemsGettingDataErrorState());
    });
  }

  var piker =ImagePicker();
  File? itemImg;
  void pickImg() async{
    emit(ItemsPickingImgLoadingState());
     final pickedFile= await piker.pickImage(source: ImageSource.gallery);
     if(pickedFile!=null){
       itemImg=File(pickedFile.path);
       emit(ItemsPickingImgSuccessState());
     }else {
       print('No Image Selected');
       emit(ItemsPickingImgErrorState());
     }
  }

  ///*************************************

//to add new category >> this will be used in uploadCategoryImg

  void postItem({
    required String itemName,
    required String itemImg,
    required String itemDescription,
    required String itemPrice,

  }) {
    itemsModel= ItemsModel(
        img:itemImg,
        name:itemName,
        price: itemPrice,
        description: itemDescription,
        category: categoryId
    );
    FirebaseFirestore.instance
        .collection('items')
        .add(itemsModel!.toJson())
        .then((value) {
      emit(ItemsPostingDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ItemsPostingDataErrorState());
    });

  }

  void uploadItemImg({
    required String itemName,
    required String itemDescription,
    required String itemPrice,
  }){
    emit( ItemsUploadingImgLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("items/${Uri.file(itemImg!.path).pathSegments.last}")
        .putFile(itemImg!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        emit(ItemsUploadingImgSuccessState());
        postItem(
            itemName: itemName,
            itemImg: value,
          itemDescription: itemDescription,
          itemPrice: itemPrice
        );
        emit(ItemsDownLoadingImgUrlSuccessState());
      })
          .catchError((error){
        print(error.toString());
        emit(ItemsDownLoadingImgUrlErrorState());
      });
    }

    ).catchError((error){
      emit(ItemsUploadingImgErrorState());
    });
  }
/// delete Item
  void removeItem({
    required String itemName,
  }){

    FirebaseFirestore.instance
        .collection("items")
        .where("name",isEqualTo: itemName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      emit(ItemsGettingDataSuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("items")
            .doc(documentId)
            .delete()
            .then((value) {
          emit(ItemsDeleteDataSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(ItemsDeleteDataErrorState());
        });
      }
      else {
     print("There Are More than one item with this name");
      }
    });
  }

  ///*************************************

  void updateItem({
    required String itemName,

    required String itemUpdatedName,
    // required String itemUpdatedDescription,
    required String itemUpdatedPrice,
    String? categoryUpdatedImg,
  }){
    itemsModel =ItemsModel (
        name: itemUpdatedName,
        img: categoryUpdatedImg,
      description: "Bla Bla Bla",
      category: categoryId
    );
    FirebaseFirestore.instance
        .collection("items")
        .where("name",isEqualTo: itemName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      emit(ItemsGettingDataSuccessState());
      if (querySnapshot.size == 1) {
        String documentId = querySnapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection("items")
            .doc(documentId)
            .update(itemsModel!.toJson())
            .then((value) {
          emit(ItemsUpdatingDataSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(ItemsUpdatingDataErrorState());
        });
      }
      else {
        print("There are more an Items with the same name");
      }
    });
  }

  // String? catImg; // this to inform that the image in not updated
  void uploadUpdatedItemImg({
    required String itemName,
    required int index,
    String? itemUpdatedName,
    // String? itemUpdatedDescription,
    String? itemUpdatedPrice,
  }){
    emit( ItemsUploadingUpdatedImgLoadingState());
    if (itemImg!=null){
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child("items/${Uri.file(itemImg!.path).pathSegments.last}")
          .putFile(itemImg!)
          .then((value){
        value.ref.getDownloadURL().then((value) {
          emit(ItemsUploadingUpdatedImgSuccessState());
          updateItem(
              itemName:itemName,
              categoryUpdatedImg: value,
              itemUpdatedName: itemUpdatedName ?? "${items[index].name}",
              itemUpdatedPrice: itemUpdatedPrice?? "${items[index].price}",
            // itemUpdatedDescription:itemUpdatedDescription??" ${items[index].description}",
          );

          emit(ItemsDownLoadingUpdatedImgUrlSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(ItemsDownLoadingImgUrlErrorState());
        });
      }

      ).catchError((error){
        emit(ItemsUploadingUpdatedImgErrorState());
      });
    }else {
      // updateItem(
      //     itemName:itemName,
      //     itemUpdatedName: itemUpdatedName ?? "${items[index].name}",
      //     categoryUpdatedImg: "${items[index].img}"
      // );
    }

  }



}