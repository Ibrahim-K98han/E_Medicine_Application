class CartModel {
  String? idCart;
  String? quantity;
  String? name;
  String? image;
  String? price;

  CartModel({
    this.idCart,
    this.quantity,
    this.name,
    this.image,
    this.price,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    idCart = json['id_cart'];
    quantity = json['quantity'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cart'] = this.idCart;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
