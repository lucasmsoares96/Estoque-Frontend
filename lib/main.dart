import 'package:estoque_frontend/models/user.dart';
import 'package:estoque_frontend/pages/login_page.dart';
import 'package:estoque_frontend/widgets/auth_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  //TODO: presistencia de dados
  //Não precisar fazer login todas as vezes
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => User(),
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: const AuthCheck(),
        routes: {
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
