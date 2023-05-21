import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firerest/home-file/home-states.dart';
import 'package:firerest/models/cart-model.dart';
import 'package:firerest/models/category-model.dart';
import 'package:firerest/models/items-model.dart';
import 'package:firerest/screens/cart-screen.dart';
import 'package:firerest/screens/explore-screen.dart';
import 'package:firerest/screens/menu-screen.dart';
import 'package:firerest/shared/cashe-helper.dart';
import 'package:firerest/shared/const.dart';
import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {

  PageController categoryPageController = PageController(viewportFraction: .85);
  PageController itemPageController = PageController();
  double currentPageValue = 0;


  List<Widget> screen = [
     ExploreScreen(),
    MenuScreen(),
    const CartScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavBarState());
  }

  HomeCubit() : super(HomeInitialState())
  {
    categoryPageController.addListener(() {
      currentPageValue = categoryPageController.page!;
    });
    itemPageController.addListener(() {
      currentPageValue = itemPageController.page!;
    });
    emit(HomeInitiatePageViewState());

  }


  @override
  Future<void> close() {
    categoryPageController.dispose();
    itemPageController.dispose();
    return super.close();
  }


  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

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
            .then((value){
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
    FirebaseFirestore.instance
        .collection("items")
        .where("categoryId",isEqualTo: categoryName)
        .get()
        .then((QuerySnapshot itemsQuerySnapshot) {
      emit(ItemsGettingDataSuccessState());
      itemsQuerySnapshot.docs.forEach((itemDoc){
        String itemDocumentId = itemDoc.id;
        FirebaseFirestore.instance
            .collection("items")
            .doc(itemDocumentId)
            .delete()
            .then((value) {
          emit(ItemsDeleteDataSuccessState());
        })
            .catchError((error){
          print(error.toString());
          emit(ItemsDeleteDataErrorState());
        });

      });




  });
        }
  ///************ Items ********

  List<ItemsModel> items = [];
  ItemsModel? itemsModel;
  void getItems({
    required String categoryId,
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



  ///*************************
  var piker =ImagePicker();
  File? itemImg;
  void pickItemImg() async{
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
    // required String itemDescription,
    required String itemPrice,

  }) {
    itemsModel= ItemsModel(
        img:itemImg,
        name:itemName,
        price: itemPrice,
        // description: itemDescription,
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
            // itemDescription: itemDescription,
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
    String? itemUpdatedPrice,
    String? categoryUpdatedImg,
  }){
    itemsModel =ItemsModel (
        name: itemUpdatedName,
        img: categoryUpdatedImg,
        price: itemUpdatedPrice,
        // description: "Bla Bla Bla",
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
            itemUpdatedPrice: itemUpdatedPrice ?? "${items[index].price}",
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
      print("Items");
      updateItem(
          itemName:itemName,
          itemUpdatedPrice: itemUpdatedPrice ?? "${items[index].price}",
          itemUpdatedName: itemUpdatedName ?? "${items[index].name}",
          categoryUpdatedImg: "${items[index].img}"
      );
    }

  }
///************************************************
//   Map productQuantity(products){
//     var quantity=Map();
//     products.forEach((product){
//       if (!product.contanisKey(product)){
//        quantity[product]=1;
//       } else {quantity[product]+=1;}
//     });
//     return quantity;
//   }
//   var itemQuantity=0;
// void editItemQuantity(String operation){
//   if(operation=="plus"){
//     itemQuantity= itemQuantity+1;
//     emit(ItemsIncreaseQuantityState());
//     print(itemQuantity);
//   }
//   else{
//     itemQuantity--;
//     emit(ItemsDecreaseQuantityState());
//     print(itemQuantity);
//   }
// }
 CartModel? cartModelObj;
  void addItemsToCart(name,img,price,index) {
    CartModel cartModel = CartModel(
        img: img,
        name: name,
        price:price,
    );
    cartModelObj=cartModel;
    cartItems.add(cartModel);
    emit(CartAddItemSuccessState());
  }


  bool addedToCart=false;
  void toggleCartState(index){
    // addedToCart = !addedToCart;
    items[index].addedToCart= !items[index].addedToCart!;
    CacheHelper.saveData(key: "cartItemStatus", value: items[index].addedToCart);
    // print(" ${items[index].addedToCart}");

    emit(CartUpdateCartState());

  }

}