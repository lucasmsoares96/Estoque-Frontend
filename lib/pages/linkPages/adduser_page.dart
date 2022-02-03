import 'package:estoque_frontend/models/user_model.dart';
import 'package:estoque_frontend/repositories/user_repository.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime now = DateTime.now();
DateTime date = DateTime(now.year, now.month, now.day);

String _formattedDate = DateFormat('yyyy-MM-dd').format(now);

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool _isAdmin = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _functionController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
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

  //TODO: mudar o jeito de mostrar o erro e o sucesso para serem distintos
  // Mostrar um texto em vermelho no dialog para mostrar o erro
  registerUser(User user) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    try {
      setState(() {
        isLoading = true;
      });
      if (await context
          .read<UserRepository>()
          .register(user, context.read<AuthService>().token)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuario cadastrado com sucesso"),
          ),
        );
        Navigator.of(context).pop();
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
    return AlertDialog(
      content: SizedBox(
        height: 900,
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Informações do usuário',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nome:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  maxLength: 50,
                                  cursorColor: Colors.black,
                                  decoration: inputDecoration("Nome"),
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com o seu nome";
                                    }
                                    if (!RegExp(r"^[a-zA-Z ]")
                                        .hasMatch(value)) {
                                      return "preencha com um nome válido";
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
                                'Telefone:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  maxLength: 11,
                                  cursorColor: Colors.black,
                                  decoration: inputDecoration("(DDD)9..."),
                                  controller: _telephoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com o seu telefone";
                                    }
                                    if (!RegExp(
                                            r"^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})\-?(\d{4}))")
                                        .hasMatch(value)) {
                                      return "preencha com um telefone válido";
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
                                'Email:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration:
                                      inputDecoration("exemplo@exemplo.com"),
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com o seu email";
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Função:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: inputDecoration("Cargo"),
                                  controller: _functionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com a sua função";
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
                    const Text(
                      'CPF:',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        maxLength: 11,
                        cursorColor: Colors.black,
                        decoration: inputDecoration("xxx.xxx.xxx-xx"),
                        controller: _cpfController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "preencha com o seu cpf";
                          }
                          if (!RegExp(
                                  "([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})")
                              .hasMatch(value)) {
                            return "preencha com um cpf válido";
                          }
                          return null;
                        },
                      ),
                    ),
                    SwitchListTile(
                      title: const Text("Usuario"),
                      subtitle: const Text("É administrador?"),
                      secondary: const Icon(Icons.add_moderator_outlined),
                      activeColor: Colors.purple,
                      value: _isAdmin,
                      onChanged: (e) => setState(
                        () {
                          _isAdmin = e;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Informações do Login',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Usuário:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: inputDecoration(""),
                                  controller: _userController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com o seu usuário";
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
                                'Senha:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: inputDecoration(""),
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "preencha com a sua senha";
                                    }
                                    if (value.length > 8) {
                                      return "Limite máximo de caracteres ultrapassado";
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
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //TODO: Mensagem de erro e de sucesso no cadastro
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          child: (!isLoading
                              ? const Text('Cadastrar Usuario')
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerUser(
                                User(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  cpf: _cpfController.text,
                                  userType: _functionController.text,
                                  password: _passwordController.text,
                                  isAdmin: _isAdmin,
                                  entryDate: _formattedDate,
                                ),
                              );
                              context
                                  .read<UserRepository>()
                                  .getUser(context.read<AuthService>().token);
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
      ),
    );
  }
}
