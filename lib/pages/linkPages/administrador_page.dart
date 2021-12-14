import 'dart:js';

import 'package:estoque_frontend/models/user_model.dart';
import 'package:estoque_frontend/pages/linkPages/adduser_page.dart';
import 'package:estoque_frontend/repositories/user_repository.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'adduser_page.dart';

class AdministracaoPage extends StatelessWidget {
  const AdministracaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> listUsers = context.read<UserRepository>().listUsers;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(60, 248, 247, 250),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Controle de usuarios",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.normal,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(children: <Widget>[
                  //TODO: Criar uma row com barra de pesquisa e o icon button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                        onPressed: () => showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return const AddUser();
                          },
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.refresh_outlined),
                          color: Colors.black,
                          onPressed: () async {
                            await context
                                .read<UserRepository>()
                                .fetchUser(context.read<AuthService>().token);
                            print(listUsers);
                          }),
                    ],
                  ),

                  SizedBox(
                    height: 300.0,
                    child: Consumer<UserRepository>(
                      builder: (context, usuarios, child) {
                        return usuarios.listUsers.isEmpty
                            ? Container()
                            : ListView.separated(
                                padding: const EdgeInsets.all(8),
                                itemCount: usuarios.listUsers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Nome ${usuarios.listUsers[index].name}',
                                          style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Oswald',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              );
                      },
                    ),
                  ),
                ]),
              ),
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 500.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 256, 0, 43),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: 150.0,
                              height: 150.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              "Nome",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "Função: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Oswald',
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "Entrou em: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Oswald',
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Verificar historico de atividades",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "editar informações de usuario",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Excluir usuario",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Telefone: ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Email: ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
