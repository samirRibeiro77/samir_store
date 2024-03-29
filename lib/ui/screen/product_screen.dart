import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:samir_store/data/cart_product.dart';
import 'package:samir_store/data/model/cart_model.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:samir_store/data/product_data.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData _product;

  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState(_product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData _product;
  String selectedSize;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
              images: _product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  _product.title,
                  maxLines: 3,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                Text("R\$ ${_product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor)),
                SizedBox(
                  height: 16.0,
                ),
                Text("Tamanho",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: _product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                color: selectedSize != size
                                    ? Colors.grey[500]
                                    : primaryColor,
                                width: 3.0),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: selectedSize != null
                        ? () {
                          if(UserModel.of(context).isLoggendIn) {
                            var cartProduct = CartProduct();
                            cartProduct.size = selectedSize;
                            cartProduct.quantity = 1;
                            cartProduct.productId = _product.id;
                            cartProduct.category = _product.category;
                            cartProduct.productData = _product;

                            CartModel.of(context).addCartItem(cartProduct);

                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context)=>CartScreen()
                                )
                            );
                          }
                          else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context)=>LoginScreen()
                              )
                            );
                          }
                        }
                        : null,
                    color: primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      UserModel.of(context).isLoggendIn
                          ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Descrição",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                Text(_product.description,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
