import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samir_store/data/cart_product.dart';
import 'package:samir_store/data/product_data.dart';

class CartTile extends StatelessWidget {

  final CartProduct _cartProduct;

  CartTile(this._cartProduct);

  Widget _buildContent() {

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _cartProduct.productData != null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection("products")
                  .document(_cartProduct.category).collection("items")
                  .document(_cartProduct.productId).get(),

              builder: (context, snapshot){
                if(snapshot.hasData) {
                  _cartProduct.productData = ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                }
                else {
                  return Container(
                    height: 70.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent(),
    );
  }
}
