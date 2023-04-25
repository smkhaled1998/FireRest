class UserModel{
  String? name;
  String? phone;
  String? uId;
  String? about;
  String? email;
UserModel({this.phone,this.email,this.name,this.about,this.uId});

UserModel.fromJason(Map <String,dynamic> json){
  name=json['name'];
  phone=json['phone'];
  uId=json['uId'];
  about=json['about'];
  email=json['email'];
}

Map<String,dynamic> toMap(){
  return {
    "email":email,
    "phone":phone,
    "uId":uId,
    "about":about,
    "name":name,
  };
}
}