import 'dart:convert';
import 'dart:collection';
import 'package:estoque_frontend/models/product_model.dart';
import 'package:estoque_frontend/models/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

final String port = dotenv.env['port']!;
final String ip = dotenv.env['ip']!;

class ProductRepository extends ChangeNotifier {
  final List<Product> _products = [];
  final List<Stock> _stocks = [];
  ProductRepository();

  getStock(String? token) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://$ip:$port/getStock'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _stocks.clear();
        for (var item in json) {
          _stocks.add(
            Stock(
              id: item[0],
              quantity: item[1],
            ),
          );
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
        Uri.parse('http://$ip:$port/products/$name'),
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

  getProduct(String? token) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://$ip:$port/products'),
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

  Future<bool> registerProduct(Product product, String token) async {
    Map<String, dynamic> json = <String, dynamic>{
      "product": product.toMap(),
    };
    final response = await http.post(
      Uri.parse('http://$ip:$port/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(json),
    );
    if (response.statusCode != 200) {
      throw "Erro ao cadastrar produto";
    } else {
      _products.add(product);
      notifyListeners();
      return true;
    }
  }

  Future<bool> updateProduct(Product product, String? token) async {
    Map<String, dynamic> json = <String, dynamic>{
      "product": product.toMap(),
    };
    final response = await http.put(
      Uri.parse('http://$ip:$port/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token!,
      },
      body: jsonEncode(json),
    );
    if (response.statusCode != 200) {
      throw "Erro ao atualizar produto";
    } else {
      var indexOfProduct = _products
          .indexWhere((productinList) => productinList.id == product.id);
      if (indexOfProduct != -1) {
        _products.removeAt(indexOfProduct);
        _products.add(product);
      }
      notifyListeners();
      return true;
    }
  }

  deleteProduct(Product product, String token) async {
    Map<String, dynamic> json = <String, dynamic>{
      "product": product.toMap(),
    };
    final response = await http.delete(
      Uri.parse('http://$ip:$port/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(json),
    );
    if (response.statusCode != 200) {
      throw "Erro ao deletar produto";
    }
    _products.remove(product);
    notifyListeners();
  }

  UnmodifiableListView<Product> get listProducts =>
      UnmodifiableListView(_products);
}
