import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String _id, _title, _description, _category;
  double _price;
  List<String> _images, _sizes;

  ProductData.fromDocument(DocumentSnapshot doc) {
    this._id = doc.documentID;
    this._title = doc.data["title"];
    this._description = doc.data["description"];
    this._price = double.parse(doc.data["price"].toString());
    this._images = doc.data["images"];
    this._sizes = doc.data["sizes"];
  }
}