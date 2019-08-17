import 'package:flutter/material.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:samir_store/ui/screen/login_screen.dart';
import 'package:samir_store/ui/widget/tile/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageControler;

  CustomDrawer(this._pageControler);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Samir's\nStore",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Olá, ${!model.isLoggendIn ? "" : model.userName}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!model.isLoggendIn) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  } else {
                                    model.signOut();
                                  }
                                },
                                child: Text(
                                  !model.isLoggendIn
                                      ? "Entre ou cadastre-se"
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        }))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", _pageControler, 0),
              DrawerTile(Icons.list, "Produtos", _pageControler, 1),
              DrawerTile(Icons.location_on, "Lojas", _pageControler, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus pedidos", _pageControler, 3),
            ],
          )
        ],
      ),
    );
  }
}
