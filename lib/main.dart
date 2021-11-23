import 'package:estoque_frontend/login.dart';
import 'package:estoque_frontend/tab_fetch.dart';
import 'package:estoque_frontend/user_page.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Página de Login",
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/userPage': (context) => const UserPage(),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'search',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: Login(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: UserFetchTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
