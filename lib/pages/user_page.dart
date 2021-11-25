import 'package:estoque_frontend/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, Key? key}) : super(key: key);
  final User user;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CupertinoButton(
            child: Text(widget.user.name),
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop('/login'),
          ),
        ],
      ),
    );
  }
}
