import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthService>().logout();
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/login');
            },
            child: const Text("Sair"),
          )
        ],
      ),
    );
  }
}
