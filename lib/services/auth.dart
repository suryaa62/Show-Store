import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum LoginStatus {
  loggedout,
  loggedIn,
  signup,
  emailVerification,
}

class LoginState extends ChangeNotifier {
  LoginState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null && user.emailVerified) {
        _status = LoginStatus.loggedIn;
      } else if (user != null && !user.emailVerified) {
        _status = LoginStatus.emailVerification;
        notifyListeners();
        await user.sendEmailVerification();
        Timer.periodic(Duration(seconds: 5), (timer) async {
          await FirebaseAuth.instance.currentUser.reload();
          if (FirebaseAuth.instance.currentUser.emailVerified) timer.cancel();
          print("run");
        });
      } else {
        _status = LoginStatus.loggedout;
      }
      notifyListeners();
    });
  }

  LoginStatus _status = LoginStatus.loggedout;
  LoginStatus get status => _status;

  void startSignUp() {
    _status = LoginStatus.signup;
    notifyListeners();
  }

  //login with email id and password
  void loginWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<bool> verifyEmail(String email,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var method =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (method.contains('password'))
        return true;
      else
        return false;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void registerWithEmailAndPassword(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistrarion() {
    _status = LoginStatus.loggedout;
    notifyListeners();
  }

  //logout
  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
