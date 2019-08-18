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


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadUser();
  }

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

  Future<Null> _loadUser() async {
    if(_firebaseUser == null) {
      _firebaseUser = await _auth.currentUser();
    }

    if(_firebaseUser != null && _userData == null) {
      var docSnapshot = await Firestore.instance.collection("users").document(_firebaseUser.uid).get();
      _userData = UserData.fromMap(docSnapshot.data);
    }

    notifyListeners();
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

    }).catchError((e) {

      onError();

    }).whenComplete((){_finishLoading();});
  }

  void signIn({
    @required String email,
    @required String password,
    @required VoidCallback onSuccess,
    @required VoidCallback onError
  }) async {
    _startLoading();

    await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((user) async {

      _firebaseUser = user;
      await _loadUser();
      onSuccess();

    }).catchError((e) {

      onError();

    }).whenComplete((){_finishLoading();});
  }

  void signOut() async {
    _startLoading();

    await _auth.signOut();

    _userData = null;
    _firebaseUser = null;

    _finishLoading();
  }

  void recoverPassword(String email){
    _auth.sendPasswordResetEmail(email: email);
  }
}
