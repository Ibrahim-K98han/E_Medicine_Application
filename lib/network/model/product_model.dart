class CategoryWithProduct {
  String? idCategory;
  String? category;
  String? image;
  String? status;
  List<ProductModel>? product;

  CategoryWithProduct({
    this.idCategory,
    this.category,
    this.image,
    this.status,
    this.product,
  });

  CategoryWithProduct.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    category = json['category'];
    image = json['image'];
    status = json['status'];
    if (json['product'] != null) {
      product = <ProductModel>[];
      json['product'].forEach((v) {
        product!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategory'] = this.idCategory;
    data['category'] = this.category;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? idProduct;
  String? idCategory;
  String? name;
  String? description;
  String? image;
  String? price;
  String? status;
  String? createdAt;

  Product(
      {this.idProduct,
      this.idCategory,
      this.name,
      this.description,
      this.image,
      this.price,
      this.status,
      this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    idCategory = json['id_category'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['id_category'] = this.idCategory;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductModel {
  String? idProduct;
  String? idCategory;
  String? name;
  String? description;
  String? image;
  String? price;
  String? status;
  String? createdAt;

  ProductModel(
      {this.idProduct,
      this.idCategory,
      this.name,
      this.description,
      this.image,
      this.price,
      this.status,
      this.createdAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    idCategory = json['id_category'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['id_category'] = this.idCategory;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
