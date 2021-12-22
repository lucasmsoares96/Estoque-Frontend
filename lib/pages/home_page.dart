import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';

import 'linkPages/administrador_page.dart';
import 'linkPages/gerenciador_page.dart';
import 'linkPages/historico_page.dart';
import 'linkPages/perfil_page.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  _selectedPage(int index) {
    setState(() => _index = index);
  }

  _getPageItem(int index) {
    switch (index) {
      case 0:
        return const GerenciadorPage();
      case 1:
        return const PerfilPage();
      case 2:
        return const AdministracaoPage();
      case 3:
        return const HistoricoPage();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    double _space = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 222, 168, 254),
                Color.fromARGB(255, 158, 79, 222),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _selectedPage(0);
            },
            child: const Text(
              "Gerenciar Produtos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _space, vertical: 10),
          ),
          TextButton(
            onPressed: () {
              _selectedPage(1);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Perfil",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          context.read<AuthService>().user!.isAdmin!  ? 
          Row(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: _space)),
              TextButton(
                onPressed: () {
                  _selectedPage(2);
                },
                child: const Text(
                  "Administração",
                  style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          )
          : const SizedBox(),
          
          Padding(padding: EdgeInsets.symmetric(horizontal: _space)),
          TextButton(
            onPressed: () {
              _selectedPage(3);
            },
            child: const Text(
              "Histórico",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _space),
          ),
        ],
      ),
      body: _getPageItem(_index),
    );
  }
}
