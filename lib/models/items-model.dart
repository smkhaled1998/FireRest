

import 'package:firerest/shared/cashe-helper.dart';

class ItemsModel{
  String? img;
  String? name;
  String? price;
  bool? addedToCart=CacheHelper.getData(key:"cartItemStatus");
  // String? description;
  String? category;
  ItemsModel({
    this.img,
    this.name,
    this.price,
    this.addedToCart,
    // this.description,
  this.category});
  ItemsModel.fromJson(Map<String,dynamic> json){
    img=json['img'];
    name=json ['name'];
    price=json ['price'];
    category=json ['categoryId'];
    // description=json ['description'];
  }
  Map<String,dynamic> toJson(){
    return {
      'img':img,
      'name':name,
      // 'description':description,
      'price':price,
      'categoryId':category,
    };
  }

}
