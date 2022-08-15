import 'dart:convert';
import 'package:amazon_lite/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiartyDate;
  String? _userId;

  bool get isAuthenticated {
    return _token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_token != null &&
        _expiartyDate != null &&
        _expiartyDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String? email, String? password, String urlSegment) async {
    try {
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD3dcMagsyrvw9wwLA0G5pnFeQcEw4jRH0';
      final response = await https.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiartyDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    return await authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String? email, String? password) async {
    return await authenticate(email, password, 'signInWithPassword');
  }
}
