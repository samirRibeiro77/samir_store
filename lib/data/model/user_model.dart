import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../user_data.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  UserData _userData;

  bool isLoading = false;
  bool get isLoggendIn => _firebaseUser != null;
  String get userName => isLoggendIn ? _userData.name : "";


  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _finishLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUser(UserData userData) async {
    this._userData = userData;
    Firestore.instance.collection("users").document(_firebaseUser.uid).setData(userData.toMap());
  }

  void signUp(
      {@required UserData userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onError}
      ) {
    _startLoading();

    _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: password
    ).then((user) async {
      _firebaseUser = user;
      await _saveUser(userData);
      onSuccess();
      _finishLoading();
    }).catchError((e) {
      onError();
      _finishLoading();
    });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 5));

    isLoading = false;
    notifyListeners();
  }

  void signOut() async {
    isLoading = true;
    notifyListeners();

    await _auth.signOut();

    _userData = null;
    _firebaseUser = null;

    isLoading = false;
    notifyListeners();
  }

//void recoverPassword(){}
}
