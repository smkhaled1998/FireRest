class CategoryModel{
  String? img;
  String? name;
CategoryModel({this.img,this.name});
  CategoryModel.fromJson(Map<String,dynamic> json){
    img=json['img'];
    name=json ['name'];
  }
  Map<String,dynamic> toJson(){
    return {
      'img':img,
      'name':name,
    };
  }

}