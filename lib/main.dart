import 'package:estoque_frontend/pages/login.dart';
import 'package:estoque_frontend/widgets/auth_check.dart';
import 'package:flutter/cupertino.dart';

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
      debugShowCheckedModeBanner: false,
      // initialRoute: '/login',
      // home: const Login(),
      home: const AuthCheck(),
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }
}
