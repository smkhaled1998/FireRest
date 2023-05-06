class ItemsModel{
  String? img;
  String? name;
  String? price;
  String? description;
  String? category;
  ItemsModel({this.img,this.name,this.price,this.description,this.category});
  ItemsModel.fromJson(Map<String,dynamic> json){
    img=json['img'];
    name=json ['name'];
    price=json ['price'];
    description=json ['description'];
  }
  Map<String,dynamic> toJson(){
    return {
      'img':img,
      'name':name,
      'description':description,
      'price':price,
      'category':category,
    };
  }

}