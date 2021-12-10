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
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  login() async {
    setState(() {
      loading = true;
    });
    try {
      await context
          .read<AuthService>()
          .login(email: _emailController.text, senha: _passwordController.text);
    } catch (e) {
      setState(
        () {
          loading = false;
        },
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white)),
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 222, 168, 254),
                    Color.fromARGB(255, 158, 79, 222),
                  ],
                ),
              ),
            ),
            Center(
              child: buildForm(context),
            ),
          ],
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
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
              child: TextFormField(
                cursorColor: Colors.white,
                decoration: inputDecoration("Email", Icons.person_outlined),
                controller: _emailController,
                enabled: !loading,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite seu email.";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                cursorColor: Colors.white,
                decoration: inputDecoration("Senha", Icons.lock_outlined),
                controller: _passwordController,
                enabled: !loading,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite uma senha.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 70, left: 70),
              child: !loading
                  ? ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
            ),
            TextButton(
              child: const Text(
                "Esqueci minha senha",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
