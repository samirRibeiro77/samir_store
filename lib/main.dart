import 'package:flutter/material.dart';
import 'package:samir_store/ui/screen/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/model/cart_model.dart';
import 'data/model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: 'Samir\'s Store',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255, 4, 125, 141)
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          }
      )
    );
  }
}