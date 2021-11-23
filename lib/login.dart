import 'package:flutter/cupertino.dart';
import 'user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                Map<String, dynamic> user = {
                  "email": _emailController.text,
                  "password": _passwordController.text,
                };
                _futureUser = login(user);
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
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CupertinoActivityIndicator();
      },
    );
  }
}
