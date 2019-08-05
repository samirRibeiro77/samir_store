import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samir_store/data/product_data.dart';
import 'package:samir_store/ui/widget/tile/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot _doc;

  CategoryScreen(this._doc);

  Widget _createScreen(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    } else {
      return TabBarView(
          children: [_createGridView(snapshot), _createListView(snapshot)]);
    }
  }

  Widget _createGridView(AsyncSnapshot<QuerySnapshot> snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 0.65),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return ProductTile(
              "grid", ProductData.fromDocument(snapshot.data.documents[index]));
        });
  }

  Widget _createListView(AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView.builder(
        padding: EdgeInsets.all(4.0),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return ProductTile(
              "list", ProductData.fromDocument(snapshot.data.documents[index]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(_doc.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list))
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(_doc.documentID)
                  .collection("items")
                  .getDocuments(),
              builder: (context, snapshot) {
                return _createScreen(snapshot);
              })),
    );
  }
}
