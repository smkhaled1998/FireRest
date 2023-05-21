class CartModel {
  String? img;
  String? name;
  String? price;
  // bool addedToCart = true;
  String? quantity;

  CartModel({
    this.img,
    this.name,
    this.price,
    this.quantity,
    // this.addedToCart=true
  });

  CartModel.fromJson(Map<String, dynamic> json){
    img = json['img'];
    name = json ['name'];
    price = json ['price'];
    quantity = json ['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
