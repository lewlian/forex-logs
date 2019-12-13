import 'dart:async';
import 'package:flutter/material.dart';

//In this service, we are using a mixin called ChangeNotifier and a method notifyListeners this will allow for the widgets that are using this Service to be updated when the method is called. We are calling notifyListeners when we update the currentUser property because that means that the user has either logged in or logged out and we want the application to update based on the users state.

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print("new AuthService");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}

  // logs in the user if password matches
  Future loginUser({String email, String password}) {
    if (password == 'password123') {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }
}
