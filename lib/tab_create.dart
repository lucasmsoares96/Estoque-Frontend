import 'package:flutter/cupertino.dart';
import 'user.dart';

class UserCreateTab extends StatefulWidget {
  const UserCreateTab({Key? key}) : super(key: key);

  @override
  State<UserCreateTab> createState() => _UserCreateTabState();
}

class _UserCreateTabState extends State<UserCreateTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoTextField(
          controller: _nameController,
        ),
        CupertinoTextField(
          controller: _emailController,
        ),
        CupertinoTextField(
          controller: _ageController,
        ),
        CupertinoButton(
          onPressed: () {
            setState(() {
              Map<String, dynamic> user = {
                "name": _nameController.text,
                "email": _emailController.text,
                "age": int.parse(_ageController.text),
              };
              _futureUser = createUser(user);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CupertinoActivityIndicator();
      },
    );
  }
}
