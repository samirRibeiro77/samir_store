import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samir_store/data/product_data.dart';

class CartProduct {
  String cartProductId;
  String category;
  String productId;
  int quantity;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot doc) {
    this.cartProductId = doc.documentID;
    this.category = doc.data["category"];
    this.productId = doc.data["productId"];
    this.quantity = doc.data["quantity"];
    this.size = doc.data["size"];
    getProduct().then((doc) {
      this.productData = ProductData.fromDocument(doc);
    });
  }

  Future<DocumentSnapshot> getProduct() async {
    return Firestore.instance.collection("products")
        .document(this.category).collection("items")
        .document(this.productId).get();
  }

  Map<String, dynamic> toMap() {
    return {
      "category": this.category,
      "productId": this.productId,
      "quantity": this.quantity,
      "size": this.size,
      "product": this.productData != null ? this.productData.toResumeMap() : ""
    };
  }
}