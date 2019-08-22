import 'package:flutter/material.dart';
import 'package:samir_store/data/model/user_model.dart';

class ExitDialog {
  Future<Null> build(BuildContext context, UserModel model) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja sair do app?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  model.signOut();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
