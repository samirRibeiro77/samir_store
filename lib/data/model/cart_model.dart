import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../cart_product.dart';

class CartModel extends Model {
  UserModel _user;
  List<CartProduct> products = [];

  CartModel(this._user);

  bool isLoading = false;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct product) {
    products.add(product);
    Firestore.instance.collection("users").document(_user.userId)
        .collection("cart").add(product.toMap()).then((doc){
          product.cartProductId = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    Firestore.instance.collection("users").document(_user.userId)
        .collection("cart").document(product.cartProductId).delete();
    products.remove(product);

    notifyListeners();
  }
}