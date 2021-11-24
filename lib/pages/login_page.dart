import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: buildColumn(),
    );
  }

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

                // Map<String, dynamic> user = {
                //   "email": _emailController.text,
                //   "password": _passwordController.text,
                // };
                // _futureUser = login(user);

                // TODO: CupertinoAlertDialog
                // mostrar mensagem de erro quando o usuário informar a
                // a senha errada

                Navigator.of(context, rootNavigator: true).pushNamed('/home');
              },
            );
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
