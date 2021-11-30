import 'package:estoque_frontend/pages/home_page.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  Future<int?>? _statusCode;
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
        child: (_statusCode == null) ? buildStack() : buildFutureBuilder(),
      ),
    );
  }

  Stack buildStack() {
    return Stack(children: [
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
          // TODO: validar formulário
          child: Container(
            width: 500,
            decoration: const BoxDecoration(color: Colors.white10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CupertinoTextField(
                    decoration: inputDecoration(),
                    suffix: const Icon(
                      CupertinoIcons.person,
                      color: Colors.black,
                    ),
                    placeholder: "Login",
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    enabled: !loading,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CupertinoTextField(
                    decoration: inputDecoration(),
                    suffix: const Icon(
                      CupertinoIcons.lock,
                      color: Colors.black,
                    ),
                    placeholder: "Senha",
                    controller: _passwordController,
                    enabled: !loading,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 70, left: 70),
                  child: CupertinoButton.filled(
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text("Login"),
                      onPressed: () {
                        setState(() {
                          loading = true;
                          _statusCode = context.read<AuthService>().login(
                              email: _emailController.text,
                              senha: _passwordController.text);
                        });
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
    ]);
  }

  FutureBuilder<int?> buildFutureBuilder() {
    return FutureBuilder<int?>(
      future: _statusCode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          loading = false;
          // TODO: if _statuscode != 200 return mensagem de erro
          return const Home();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
