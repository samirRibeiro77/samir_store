import 'package:flutter/material.dart';
import 'package:samir_store/data/model/cart_model.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:samir_store/ui/widget/card/discount_card.dart';
import 'package:samir_store/ui/widget/tile/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';

class CartScreen extends StatelessWidget {

  Widget _buidCart(CartModel model) {
    return ListView(
      children: <Widget>[
        Column(
          children: model.products.map((product){
            return CartTile(product);
          }).toList(),
        ),
        DiscountCard()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                var qtdProducts = model.products.length;
                return Text(
                  "${qtdProducts ?? 0} ${qtdProducts == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggendIn) {
            return Center(child: CircularProgressIndicator());
          } else if (!UserModel.of(context).isLoggendIn) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Faça login para adicionar produtos!",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    },
                  )
                ],
              ),
            );
          }
          else if(model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)
              )
            );
          }
          else {
            return _buidCart(model);
          }
        },
      ),
    );
  }
}
