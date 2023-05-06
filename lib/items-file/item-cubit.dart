import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firerest/items-file/item-states.dart';
import 'package:firerest/models/items-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
}