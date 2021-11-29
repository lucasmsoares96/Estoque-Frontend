import 'dart:convert';

import 'package:estoque_frontend/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  late SharedPreferences _prefs;
  User? user;
  bool isLoading = false;

  AuthService() {
    _startLogin();
  }
  _startLogin() async {
    await _getSharedInstance();
    await _checkLogin();
  }

  _getSharedInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // TODO: Substituir essa implementacao por token JWT
  _checkLogin() async {
    isLoading = true;
    String? nome = _prefs.getString("nome");
    String? email = _prefs.getString("email");
    // print(nome == null);
    // print(email == null);
    if (nome != null && email != null) {
      user = User(name: nome, email: email);
      notifyListeners();
      isLoading = false;
    }
  }

  _setLoginCache(User user) async {
    await _prefs.setString("nome", user.name);
    await _prefs.setString("email", user.email);
  }

  login({required String email, required String senha}) async {
    Map<String, String> credentials = {"email": email, "senha": senha};
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
      notifyListeners();
      // return response.statusCode;
    } else {
      throw Exception('Erro ao fazer login');
    }
  }

  _logout() async {
    await _prefs.remove("nome");
    await _prefs.remove("email");
    notifyListeners();
  }
}
