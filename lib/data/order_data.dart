import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_product.dart';

class OrderData {
  double _productPrice, _shipPrice, _discountPrice, _totalPrice;
  String _clientId;
  List<CartProduct> _products;
  int _status;

  OrderData(this._productPrice, this._shipPrice, this._discountPrice,
      this._clientId, this._products){

    this._status = 1;
    this._totalPrice =
        this._productPrice + this._shipPrice - this._discountPrice;

  }

  Map<String, dynamic> toMap() {
    return {
      "productsPrice": _productPrice,
      "shipPrice": _shipPrice,
      "discountPrice": _discountPrice,
      "totalPrice": _totalPrice,
      "clientId": _clientId,
      "products": _products.map((p) => p.toMap()).toList(),
      "status": _status
    };
  }

  OrderData.fromDocument(DocumentSnapshot doc) {
    this._productPrice = doc.data["productsPrice"];
    this._shipPrice = doc.data["shipPrice"];
    this._discountPrice = doc.data["discountPrice"];
    this._totalPrice = doc.data["totalPrice"];
    this._clientId = doc.data["clientId"];
    this._status = doc.data["status"];
  }
}