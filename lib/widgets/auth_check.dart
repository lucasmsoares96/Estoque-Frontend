import 'package:estoque_frontend/pages/home_page.dart';
import 'package:estoque_frontend/pages/login_page.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    if (auth.isLoading) {
      return loading();
    } else if (auth.user == null) {
      return const LoginPage();
    } else {
      return const Home();
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
