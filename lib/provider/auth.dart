import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiartyDate;
  late String _userId;

  Future<void> signUp(String? email, String? password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD3dcMagsyrvw9wwLA0G5pnFeQcEw4jRH0';
    final response = await https.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
  }
}
