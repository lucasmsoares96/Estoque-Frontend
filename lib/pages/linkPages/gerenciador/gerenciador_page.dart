import 'package:estoque_frontend/pages/linkPages/gerenciador/add_product_popup.dart';
import 'package:estoque_frontend/repositories/product_repository.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GerenciadorPage extends StatelessWidget {
  const GerenciadorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
              ),
            ],
          ),
          width: width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TODO : barra de pesquisa
              Container(
                alignment: Alignment.topCenter,
                width: width * 0.7,
                constraints: const BoxConstraints(minHeight: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("id"),
                          const Text("Nome"),
                          const Text("Tag"),
                          const Text("Ultima modificação"),
                          const Text("Quantidade"),
                          IconButton(
                              onPressed: () => showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return const AddProduct(
                                        product: null,
                                      );
                                    },
                                  ),
                              icon: const Icon(Icons.add)),
                          IconButton(
                              icon: const Icon(Icons.refresh_outlined),
                              color: Colors.black,
                              onPressed: () async {
                                await context
                                    .read<ProductRepository>()
                                    .getProduct(
                                        context.read<AuthService>().token);
                                print(
                                  context
                                      .read<ProductRepository>()
                                      .listProducts
                                      .toString(),
                                );
                              }),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 300.0,
                        child: Consumer<ProductRepository>(
                          builder: (context, produtos, child) {
                            return produtos.listProducts.isEmpty
                                ? Container()
                                : ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: produtos.listProducts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                              ' ${produtos.listProducts[index].name}',
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Oswald',
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          IconButton(
                                            onPressed: () => showDialog(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AddProduct(
                                                  product: produtos
                                                      .listProducts[index],
                                                );
                                              },
                                            ),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              String? token;
                                              try {
                                                token = context
                                                    .read<AuthService>()
                                                    .user!
                                                    .token;
                                                await produtos.deleteProduct(
                                                    produtos
                                                        .listProducts[index],
                                                    token!);
                                                await context
                                                    .read<ProductRepository>()
                                                    .getProduct(context
                                                        .read<AuthService>()
                                                        .token);
                                              } catch (erro) {}
                                            },
                                            icon: const Icon(Icons.delete),
                                          )
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
