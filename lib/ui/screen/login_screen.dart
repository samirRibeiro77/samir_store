import 'package:flutter/material.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:samir_store/ui/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen())
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());

            return Form(
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
                )
            );
          },
        )
    );
  }
}