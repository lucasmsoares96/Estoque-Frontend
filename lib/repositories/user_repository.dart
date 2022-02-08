import 'dart:convert';
import 'dart:collection';
import 'package:estoque_frontend/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String port = dotenv.env['port']!;
final String ip = dotenv.env['ip']!;

class UserRepository extends ChangeNotifier {
  final List<User> _usuarios = [];
  UserRepository();

  Future<bool> register(User user, String token) async {
    Map<String, dynamic> json = <String, dynamic>{
      "user": user.toMap(),
    };
    final response = await http.post(
      Uri.parse('http://$ip:$port/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(json),
    );

    if (response.statusCode != 200) {
      throw "Erro ao cadastrar usuario";
    } else {
      return true;
    }
  }

  Future<bool> updateUser(User user, String token) async {
    final response = await http.get(
      Uri.parse('http://$ip:$port/getUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    final json = jsonDecode(response.body);

    User tempUser = User(
      cpf: json[0],
      name: json[1],
      entryDate: json[2],
      userType: json[3],
      email: user.email,
      isAdmin: json[5] == 1 ? true : false,
    );

    Map<String, dynamic> jsonUpdate = <String, dynamic>{
      "user": tempUser.toMap()
    };
    final responseUpdate = await http.put(
      Uri.parse('http://$ip:$port/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(jsonUpdate),
    );

    if (responseUpdate.statusCode != 200) {
      throw "Erro ao modificar os dados";
    } else {
      return true;
    }
  }

  Future<bool> updatePassword(
      String oldPassword, String newPassword, String token) async {
    Map<String, dynamic> json = <String, dynamic>{
      "user": <String, dynamic>{
        "newPassword": newPassword,
        "oldPassword": oldPassword,
      }
    };

    final response = await http.put(
      Uri.parse('http://$ip:$port/updatePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(json),
    );

    if (response.statusCode != 200) {
      throw "Erro ao modificar os dados";
    } else {
      return true;
    }
  }

  getUser(String? token) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://$ip:$port/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        if (response.body == "This user is not Admin") {
          throw "error de autenticacao";
        }
        final json = jsonDecode(response.body);
        _usuarios.clear();
        for (var item in json) {
          _usuarios.add(
            User(
              name: item[0],
              userType: item[2],
              email: item[3],
              isAdmin: (item[4] == 1 ? true : false),
            ),
          );
        }
        notifyListeners();
      } else {
        throw "erro ao contactar o servidor";
      }
    } else {
      throw "erro ao buscar usuarios";
    }
  }

  UnmodifiableListView<User> get listUsers => UnmodifiableListView(_usuarios);
}
