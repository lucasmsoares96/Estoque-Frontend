import 'dart:convert';
import 'dart:collection';
import 'package:estoque_frontend/models/product_model.dart';
import 'package:estoque_frontend/models/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class ProductRepository extends ChangeNotifier {
  List<Product> _products = [];
  List<Stock> _stocks = [];
  ProductRepository() {}
  fetchStock(String? token) async {
    if (token != null) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/getStock'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'token': token}),
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

  fetchProduct(String? token) async {
    if (token != null) {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/getProducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'token': token}),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _products.clear();
        for (var item in json) {
          _products.add(Product(
            id: item[0],
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

  registerProduct(Product product) async {
    print("MAPA:");
    print(product.toMap());
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/registerProduct'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toMap()),
    );

    if (response.statusCode != 200) {
      throw "Erro ao cadastrar produto";
    }
  }

  UnmodifiableListView<Product> get listProducts =>
      UnmodifiableListView(_products);
}
