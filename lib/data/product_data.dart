import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String _id, _title, _description, category;
  double _price;
  List _images, _sizes;

  ProductData.fromDocument(DocumentSnapshot doc) {
    this._id = doc.documentID;
    this._title = doc.data["title"];
    this._description = doc.data["description"];
    this._price = double.parse(doc.data["price"].toString());
    this._images = doc.data["images"];
    this._sizes = doc.data["sizes"];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "title": this._title,
      "description": this._description,
      "price": this._price
    };
  }

  List get sizes => _sizes;
  List get images => _images;
  double get price => _price;
  String get description => _description;
  String get title => _title;
  String get id => _id;
}