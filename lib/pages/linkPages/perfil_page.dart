import 'package:estoque_frontend/models/user_model.dart';
import 'package:estoque_frontend/pages/linkPages/gerenciador/add_product_popup.dart';
import 'package:estoque_frontend/repositories/product_repository.dart';
import 'package:estoque_frontend/repositories/user_repository.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmationController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _telephoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  inputDecoration(String hint) {
    return InputDecoration(
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black)),
      hintText: hint,
    );
  }

  updateUser(User user) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await context
          .read<UserRepository>()
          .updateUser(user, context.read<AuthService>().token)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuario modificado com sucesso"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  updatePassword(String oldPassword, String newPassword) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (await context.read<UserRepository>().updatePassword(
          oldPassword, newPassword, context.read<AuthService>().token)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Senha modificado com sucesso"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(60, 248, 247, 250),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
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
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("id"),
                              const Text("Nome"),
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
                                                  decoration:
                                                      const BoxDecoration(
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
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  ' ${produtos.listProducts[index].name}',
                                                  style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 400.0,
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
                              child: const Text(
                                "CPF:",
                                style: TextStyle(color: Colors.white),
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
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('Alterar dados:',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Digite sua senha atual:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: inputDecoration(""),
                                      controller: _passwordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != null && value.length > 8) {
                                          return "Limite máximo de caracteres ultrapassado";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 21),
                                  const Text(
                                    'Telefone:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextFormField(
                                      maxLength: 11,
                                      cursorColor: Colors.black,
                                      decoration: inputDecoration("(DDD)9..."),
                                      controller: _telephoneController,
                                      //validator: (value) {
                                      //  if (value != null &&
                                      //      !RegExp(r"^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})\-?(\d{4}))")
                                      //          .hasMatch(value)) {
                                      //    return "preencha com um telefone válido";
                                      //  }
                                      //  return null;
                                      //},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nova senha:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: inputDecoration(""),
                                      controller: _newPasswordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != null && value.length > 8) {
                                          return "Limite máximo de caracteres ultrapassado";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Email:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: inputDecoration(
                                          "exemplo@exemplo.com"),
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value != null &&
                                            value.toString().isNotEmpty &&
                                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)) {
                                          return "preencha com um email válido";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Confirmar senha:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: inputDecoration(""),
                                      controller: _confirmationController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != null &&
                                            value !=
                                                _newPasswordController.text) {
                                          return "suas senhas não conferem";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 500),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Alterar'),
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  var user = context.read<AuthService>().user;
                                  if (user != null) {
                                    if (_emailController.text == '' &&
                                        _passwordController.text == '') {
                                    } else {
                                      if (_emailController.text != '' &&
                                          _passwordController.text != '') {
                                        user.email = _emailController.text;
                                        updateUser(user);

                                        user.password =
                                            _newPasswordController.text;
                                        updatePassword(_passwordController.text,
                                            _newPasswordController.text);
                                      }

                                      if (_emailController.text != '' &&
                                          _passwordController.text == '') {
                                        user.email = _emailController.text;
                                        updateUser(user);
                                      }
                                      //if (_telephoneController.text != null) {
                                      //  user.telephone = _telephoneController.text;
                                      //}
                                      if (_passwordController.text != '' &&
                                          _emailController.text == '') {
                                        user.password =
                                            _newPasswordController.text;
                                        updatePassword(_passwordController.text,
                                            _newPasswordController.text);
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });

                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Por favor reescreva suas credenciais"),
                                          ),
                                        );
                                        context.read<AuthService>().logout();
                                      });
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.read<AuthService>().logout();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              child: const Text("Sair"),
            )
          ],
        ),
      ),
    );
  }
}
