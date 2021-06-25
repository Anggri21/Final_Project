import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _idToken, userId;
  DateTime _expiryDate;

  String _tempidToken, tempuserId;
  DateTime _tempexpiryDate;

  void tempData() {
    _idToken = _tempidToken;
    userId = tempuserId;
    _expiryDate = _tempexpiryDate;
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_idToken != null && _expiryDate.isAfter(DateTime.now()) && _expiryDate != null) {
      return _idToken;
    } else {
      return null;
    }
  }

  void signup(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDczLmuYZnq2e0G7-IFAiNgAkNswkKAsO8");
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }),
      );

      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw responseData['error']["message"];
      }

      _tempidToken = responseData["idToken"];
      tempuserId = responseData["localId"];
      _tempexpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void signin(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDczLmuYZnq2e0G7-IFAiNgAkNswkKAsO8");
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }),
      );

      var responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw responseData['error']["message"];
      }
      _tempidToken = responseData["idToken"];
      tempuserId = responseData["localId"];
      _tempexpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
