import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:estoque_frontend/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//TODO: Implementar a class authexception de forma correta
class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  late SharedPreferences _prefs;
  User? user;
  bool isLoading = true;

  AuthService() {
    _startLogin();
  }

  _startLogin() async {
    await _startPreferences();
    await _checkLogin();
  }

  _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _checkLogin() async {
    final token = _prefs.getString('token');
    if (token != null) {
      final jwt = JWT.verify(token, SecretKey('randomword'));
      user = User(
        name: jwt.payload["name"],
        email: jwt.payload["email"],
        isAdmin: jwt.payload["isAdmin"] == 0 ? true : false,
        token: token,
      );
    }
    isLoading = false;
    notifyListeners();
  }

  _setLoginCache(User user) async {
    await _prefs.setString("token", user.token!);
  }

//TODO: Tratar melhor as mensagens de erro
  login({required String email, required String senha}) async {
    Map<String, String> credentials = {"email": email, "password": senha};
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );
    if (response.statusCode == 200) {
      if (response.body == "" || response.body == null) {
        throw "No response from server";
      }
      try {
        // Verify a token
        final jwt = JWT.verify(response.body, SecretKey('randomword'));
        print('Payload: ${jwt.payload}');
        user = User(
          name: jwt.payload["name"],
          email: jwt.payload["email"],
          isAdmin: jwt.payload["isAdmin"] == 0 ? true : false,
          token: response.body,
        );
        _setLoginCache(u);
        user = u;
      } on JWTExpiredError {
        throw "jwt expired";
      } on JWTError catch (ex) {
        throw ex.message;
      }
      isLoading = false;
      notifyListeners();
    } else {
      throw "Error in connection";
    }
  }

  register(User user) async {
    print("MAPA:");
    print(user.toMap());
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/registerUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toMap()..["jwt"] = this.user!.token),
    );

    if (response.statusCode != 200) {
      throw "Erro ao cadastrar usuario";
    }
  }

  logout() async {
    await _prefs.remove("token");
    user = null;
    notifyListeners();
  }
}
