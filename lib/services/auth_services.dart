import 'dart:convert';

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

  // TODO: Substituir essa implementacao por token JWT
  _checkLogin() async {
    final nome = _prefs.getString('nome');
    final email = _prefs.getString('email');
    if (nome != null && email != null) {
      user = User(name: nome, email: email);
    }
    isLoading = false;
    notifyListeners();
  }

  _setLoginCache(User user) async {
    await _prefs.setString("nome", user.name);
    await _prefs.setString("email", user.email);
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
      User u = User.fromJson(jsonDecode(response.body));
      _setLoginCache(u);
      user = u;
      isLoading = false;
      notifyListeners();
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
    await _prefs.remove("nome");
    await _prefs.remove("email");
    user = null;
    notifyListeners();
  }
}
