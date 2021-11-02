import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<User> fetchUser(String title) async {
  final response =
      await http.get(Uri.parse('http://192.168.0.198:8080/getUser/$title'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

Future<User> createUser(Map<String, dynamic> title) async {
  final response = await http.post(
    Uri.parse('http://192.168.0.198:8080/setUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(title),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create User.');
  }
}

class User {
  final String name;
  final String email;
  final int age;

  User({
    required this.name,
    required this.email,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      age: json['age'],
    );
  }
}
