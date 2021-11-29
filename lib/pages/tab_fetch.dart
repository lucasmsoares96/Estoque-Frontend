import 'package:estoque_frontend/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserFetchTab extends StatefulWidget {
  const UserFetchTab({Key? key}) : super(key: key);

  @override
  State<UserFetchTab> createState() => _UserFetchTabState();
}

class _UserFetchTabState extends State<UserFetchTab> {
  final TextEditingController _controller = TextEditingController();
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
          controller: _controller,
        ),
        CupertinoButton(
          onPressed: () {
            setState(() {
              _futureUser = context.read<User>().fetchUser(_controller.text);
            });
          },
          child: const Text('Fetch Data'),
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
