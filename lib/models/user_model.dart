import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class User extends ChangeNotifier {
  late String name;
  late String email;

  fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Future<int> login(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );
    if (response.statusCode == 200) {
      fromJson(jsonDecode(response.body));
      notifyListeners();
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<User> fetchUser(String title) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8080/getUser/$title'));

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
