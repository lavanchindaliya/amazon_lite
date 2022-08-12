import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiartyDate;
  late String _userId;

  Future<void> authenticate(
      String? email, String? password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD3dcMagsyrvw9wwLA0G5pnFeQcEw4jRH0';
    final response = await https.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
  }

  Future<void> signUp(String? email, String? password) async {
    return await authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String? email, String? password) async {
    return await authenticate(email, password, 'signInWithPassword');
  }
}
