import 'package:flutter/material.dart';
import 'package:samir_store/data/model/user_model.dart';
import 'package:samir_store/data/user_data.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  void _onSuccess() {}

  void _onFail() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar conta"),
          centerTitle: true,
        ),
        body:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido";
                    },
                    decoration: InputDecoration(hintText: "Nome completo"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "Email inválido";
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Senha"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválido";
                    },
                    decoration: InputDecoration(hintText: "Endereço"),
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
                        "Criar conta",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          var user = UserData(_nameController.text,
                              _emailController.text, _addressController.text);

                          model.signUp(
                              userData: user,
                              password: _passwordController.text,
                              onSuccess: _onSuccess,
                              onError: _onFail);
                        }
                      }
                    )
                  )
                ],
              ));
        }));
  }
}
