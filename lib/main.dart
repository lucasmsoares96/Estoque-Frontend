import 'package:estoque_frontend/pages/login_page.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:estoque_frontend/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => User(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const AuthCheck(),
        routes: {
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
