import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:estoque_frontend/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final String port = dotenv.env['port']!;
final String ip = dotenv.env['ip']!;

//TODO: Implementar a class authexception de forma correta
class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  late SharedPreferences _prefs;
  User? user;
  bool isLoading = true;

  get token => user?.token;
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
      final jwt = JWT.verify(token, SecretKey(dotenv.env['secret']!));
      user = User(
        name: jwt.payload["name"],
        email: jwt.payload["email"],
        isAdmin: jwt.payload["isAdmin"] == 1 ? true : false,
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
  login({required String email, required String senha, }) async {
    Map<String, String> credentials = {"email": email, "password": senha};
    final response = await http.post(
      Uri.parse('$ip:$port/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );
    if (response.statusCode == 200) {
      if (response.body == "") {
        throw "No response from server";
      }
      try {
        // Verify a token
        final jwt = JWT.verify(response.body, SecretKey(dotenv.env['secret']!));
        print('Payload: ${jwt.payload}');
        User u = User(
          name: jwt.payload["name"],
          email: jwt.payload["email"],
          isAdmin: jwt.payload["isAdmin"] == 1 ? true : false,
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

  Future<bool> register(User user) async {
    print("MAPA:");
    print(user.toMap());
    final response = await http.post(
      Uri.parse('$ip:$port/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toMap()..["jwt"] = this.user!.token),
    );

    if (response.statusCode != 200) {
      throw "Erro ao cadastrar usuario";
    } else {
      return true;
    }
  }

  logout() async {
    await _prefs.clear();
    user = null;
    notifyListeners();
  }
}
