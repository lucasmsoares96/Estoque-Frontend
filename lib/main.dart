import 'package:estoque_frontend/login.dart';
import 'package:estoque_frontend/user_page.dart';
import 'package:flutter/cupertino.dart';

import 'home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  //TODO: presistencia de dados
  //Não precisar fazer login todas as vezes
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/login',
      home: const Login(),
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/userPage': (context) => const UserPage(),
      },
    );
  }
}
