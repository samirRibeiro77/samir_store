import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samir_store/data/product_data.dart';

class CartProduct {
  String cartProductId;
  String _category;
  String _productId;
  int _quantity;
  String _size;

  ProductData _product;

  CartProduct.fromDocument(DocumentSnapshot doc) {
    this.cartProductId = doc.documentID;
    this._category = doc.data["category"];
    this._productId = doc.data["productId"];
    this._quantity = doc.data["quantity"];
    this._size = doc.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": this._category,
      "productId": this._productId,
      "quantity": this._quantity,
      "size": this._size,
      "product": this._product.toResumeMap()
    };
  }
}