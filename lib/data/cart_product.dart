import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samir_store/data/product_data.dart';

class CartProduct {
  String cartProductId;
  String category;
  String productId;
  int quantity;
  String size;

  ProductData _product;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot doc) {
    this.cartProductId = doc.documentID;
    this.category = doc.data["category"];
    this.productId = doc.data["productId"];
    this.quantity = doc.data["quantity"];
    this.size = doc.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": this.category,
      "productId": this.productId,
      "quantity": this.quantity,
      "size": this.size,
      "product": this._product != null ? this._product.toResumeMap() : ""
    };
  }

  ProductData get productData => _product;
  set productData(ProductData value) {
    _product = value;
  }
}