import 'package:flutter/material.dart';

class ShipCard extends StatefulWidget {
  @override
  _ShipCardState createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        leading: Icon(Icons.location_on),
        title: Text(
          "Calcular frete",
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu CEP"),
              onFieldSubmitted: (text) {},
            ),
          )
        ],
      ),
    );
  }
}
