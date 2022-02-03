import 'dart:convert';
import 'dart:collection';
import 'package:estoque_frontend/models/product_model.dart';
import 'package:estoque_frontend/models/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

final String port = dotenv.env['port']!;
final String ip = dotenv.env['ip']!;

class ProductRepository extends ChangeNotifier {
  final List<Product> _products = [];
  final List<Stock> _stocks = [];
  ProductRepository();
  fetchStock(String? token) async {
    if (token != null) {
      final response = await http.post(
        Uri.parse('$ip:$port/getStock'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'jwt': token}),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _stocks.clear();
        for (var item in json) {
          _stocks.add(Stock(
            id: item[0],
            quantity: item[1],
          ));
        }
        notifyListeners();
      } else {
        throw "erro ao contactar o servidor";
      }
    } else {
      throw "erro ao buscar estoque";
    }
  }

  Future<void> searchProducts(String? token, String name) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('$ip:$port/getProduct/$name'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _products.clear();

        for (var item in json) {
          _products.add(Product(
            name: item[0],
            productType:
                "buscar", //TODO retornar tipo de produto do banco de dados
          ));
        }
        notifyListeners();
      } else {
        throw "erro ao contactar o servidor";
      }
    } else {
      throw "erro ao buscar produtos";
    }
  }

  fetchProduct(String? token) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('$ip:$port/getProducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _products.clear();

        for (var item in json) {
          // print(item);
          _products.add(Product(
            // id: item[0],
            name: item[1],
            productType: item[2],
          ));
        }
        notifyListeners();
      } else {
        throw "erro ao contactar o servidor";
      }
    } else {
      throw "erro ao buscar produtos";
    }
  }

  registerProduct(Product product, String token) async {
    print("product map:");
    print(product.toMap());
    Map<String, dynamic> json = <String, dynamic>{
      "product": product.toMap(),
    };
    final response = await http.post(
      Uri.parse('$ip:$port/includeProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(json),
    );

    if (response.statusCode != 200) {
      throw "Erro ao cadastrar produto";
    }
  }

  UnmodifiableListView<Product> get listProducts =>
      UnmodifiableListView(_products);
}
