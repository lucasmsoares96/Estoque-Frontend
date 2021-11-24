import 'package:estoque_frontend/models/user.dart';
import 'package:estoque_frontend/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  Future<User>? _futureUser;
  inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
          ),
          Center(
            child: Form(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CupertinoTextField(
                        decoration: inputDecoration(),
                        suffix: const Icon(
                          Icons.person_outlined,
                          color: Colors.black,
                        ),
                        placeholder: "Login",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        enabled: !loading,
                        // decoration: const BoxDecoration(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CupertinoTextField(
                        decoration: inputDecoration(),
                        suffix: const Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        placeholder: "Senha",
                        controller: _passwordController,
                        enabled: !loading,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, right: 70, left: 70),
                      child: CupertinoButton.filled(
                          child: loading
                              ? const CircularProgressIndicator()
                              : const Text("Login"),
                          onPressed: () {
                            // Os validators devem ser escritos aqui
                            // PQ? pq os widgets cupertino sao merdas
                            setState(() {
                              loading = !loading;
                            });
                            // sleep(Duration(milliseconds: 5));
                            Future.delayed(Duration(milliseconds: 5));
                            Navigator.of(context).pushNamed("/home");
                          }),
                    ),
                    CupertinoButton(
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

// OLD
  Column buildColumn() {
    return Column(
      children: <Widget>[
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        const Text(
          "Email: ",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 5),
        CupertinoTextField(
          prefix: const Icon(
            CupertinoIcons.person,
            color: CupertinoColors.lightBackgroundGray,
            size: 16,
          ),
          placeholder: "Usuário",
          controller: _emailController,
        ),
        const SizedBox(height: 5),
        const Text(
          "Senha: ",
          style: TextStyle(fontSize: 10),
        ),
        CupertinoTextField(
          prefix: const Icon(
            CupertinoIcons.mail,
            color: CupertinoColors.lightBackgroundGray,
            size: 16,
          ),
          placeholder: "Senha",
          controller: _passwordController,
        ),
        CupertinoButton(
          onPressed: () {
            setState(
              () {
                // TODO: provider
                // precisamos do provider para acessar os dados do usuário
                // logado em todo o sistema

                Map<String, dynamic> user = {
                  "email": _emailController.text,
                  "password": _passwordController.text,
                };
                _futureUser = login(user);

                // TODO: CupertinoAlertDialog
                // mostrar mensagem de erro quando o usuário informar a
                // a senha errada
              },
            );
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Navigator.of(context, rootNavigator: true).pushNamed('/home');
          return Home(user: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
