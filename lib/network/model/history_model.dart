class HistoryOrderDetailModel {
  String? invoice;
  String? idUser;
  String? orderAt;
  String? status;
  List<Detail>? detail;

  HistoryOrderDetailModel(
      {this.invoice, this.idUser, this.orderAt, this.status, this.detail});

  HistoryOrderDetailModel.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    idUser = json['id_user'];
    orderAt = json['order_at'];
    status = json['status'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice'] = invoice;
    data['id_user'] = idUser;
    data['order_at'] = orderAt;
    data['status'] = status;
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? idOrders;
  String? invoice;
  String? idProduct;
  String? nameProduct;
  String? quantity;
  String? price;

  Detail(
      {this.idOrders,
      this.invoice,
      this.idProduct,
      this.nameProduct,
      this.quantity,
      this.price});

  Detail.fromJson(Map<String, dynamic> json) {
    idOrders = json['id_orders'];
    invoice = json['invoice'];
    idProduct = json['id_product'];
    nameProduct = json['nameProduct'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_orders'] = idOrders;
    data['invoice'] = invoice;
    data['id_product'] = idProduct;
    data['nameProduct'] = nameProduct;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
