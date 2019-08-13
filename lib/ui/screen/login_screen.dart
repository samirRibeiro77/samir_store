import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar conta",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "Email inválido";
                  return "";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return "Senha inválida";
                  return "";
                },
                obscureText: true,
                decoration: InputDecoration(hintText: "Senha"),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: null,
                  child:
                      Text("Esqueci minha senha", textAlign: TextAlign.right),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {

                    }
                  },
                ),
              )
            ],
          )),
    );
  }
}
