import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<User> fetchUser(String title) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8080/getUser/$title'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User');
  }
}

Future<User> login(Map<String, dynamic> credentials) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8080/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(credentials),
  );
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Erro ao fazer login');
  }
}

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }
}
