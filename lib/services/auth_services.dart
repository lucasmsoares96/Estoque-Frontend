import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:estoque_frontend/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
        name: jwt.payload["nome"],
        email: jwt.payload["email"],
        token: token,
      );
    }
    isLoading = false;
    notifyListeners();
  }

  _setLoginCache(User user) async {
    await _prefs.setString("nome", user.token);
  }

  Future<int?>? login({required String email, required String senha}) async {
    Map<String, String> credentials = {"email": email, "password": senha};
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );
    if (response.statusCode == 200) {
      try {
        // Verify a token
        final jwt = JWT.verify(response.body, SecretKey('randomword'));
        print('Payload: ${jwt.payload}');
        User u = User(
          name: jwt.payload["nome"],
          email: jwt.payload["email"],
          token: response.body,
        );
        _setLoginCache(u);
        user = u;
        isLoading = false;
        notifyListeners();
      } on JWTExpiredError {
        print('jwt expired');
      } on JWTError catch (ex) {
        print(ex.message); // ex: invalid signature
      }
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
  // Aqui nao foi usado o notifylisteners,mas pode ser usado em implementacoes futuras
  // Lista de usuarios em um repositorio atualizando dps de um usuario registrado

  register(User user) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/registerUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonDecode(user.toMap()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }

  logout() async {
    await _prefs.remove("token");
    user = null;
    notifyListeners();
  }
}
