import 'package:flutter/cupertino.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

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
            child: Text('Home :)'),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName('/')),
          ),
        ],
      ),
    );
  }
}
