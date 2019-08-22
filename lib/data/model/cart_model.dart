import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../cart_product.dart';
import '../order_data.dart';

class CartModel extends Model {
  UserModel _user;
  List<CartProduct> products = [];

  String coupon;
  int discount = 0;

  CartModel(this._user){
    if(this._user.isLoggendIn) {
      _loadCartItems();
    }
  }

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

  void decProduct(CartProduct product){
    product.quantity--;
    Firestore.instance.collection("users").document(_user.userId)
        .collection("cart").document(product.cartProductId)
        .updateData(product.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct product){
    product.quantity++;
    Firestore.instance.collection("users").document(_user.userId)
        .collection("cart").document(product.cartProductId)
        .updateData(product.toMap());
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.coupon = couponCode;
    this.discount = discountPercentage;
  }

  void updatePrices(){
    notifyListeners();
  }

  double getProductsPrice() {
    var price = 0.0;
    for(var p in products) {
      if (p.productData != null) {
        price += p.quantity * p.productData.price;
      }
    }
    return price;
  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return (getProductsPrice() * discount) / 100;
  }

  double getTotalPrice() {
    return getProductsPrice() + getShipPrice() - getDiscount();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    var order = OrderData(
        getProductsPrice(),
        getShipPrice(),
        getDiscount(),
        _user.userId,
        products
    );
    
    var ref = await Firestore.instance.collection("orders").add(order.toMap());

    await Firestore.instance.collection("users")
        .document(_user.userId).collection("orders").document(ref.documentID)
        .setData({"orderId": ref.documentID});

    var productsList = List<CartProduct>();
    products.forEach((p) => productsList.add(p));
    productsList.forEach((p) => removeCartItem(p));
    setCoupon(null, 0);

    isLoading = false;
    notifyListeners();

    return ref.documentID;
  }

  void _loadCartItems() async {
    var query = await Firestore.instance.collection("users").document(_user.userId)
        .collection("cart").getDocuments();

    products = query.documents
        .map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}