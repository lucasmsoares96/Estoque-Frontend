import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../services/auth_services.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              context.read<AuthService>().logout();
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/login');
            }, 
            child: const Text("Sair"))
        ],
      ),
    );
  }
}