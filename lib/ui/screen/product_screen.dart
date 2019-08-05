import 'package:flutter/material.dart';
import 'package:samir_store/data/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData _product;

  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState(_product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData _product;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
