import 'package:estoque_frontend/models/user.dart';
import 'package:estoque_frontend/pages/home_page.dart';
import 'package:estoque_frontend/pages/login_page.dart';
import 'package:flutter/material.dart';

// TODO: Retirar essa classe daqui,apenas modelagem
class AuthService {
  bool isLoading = false;
  User? user;
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService(); // TODO: PROVIDER CHECK
    // auth.isLoading = true;
    // auth.user = User(email: 'a', name: "a");

    if (auth.isLoading) {
      return loading();
    } else if (auth.user == null) {
      return const LoginPage();
    } else {
      return Home(user: auth.user!);
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
