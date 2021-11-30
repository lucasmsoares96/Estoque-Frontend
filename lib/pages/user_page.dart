import 'package:estoque_frontend/models/user_model.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthService>().user;
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Text(user!.name),
            onPressed: () {
              context.read<AuthService>().logout();
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
