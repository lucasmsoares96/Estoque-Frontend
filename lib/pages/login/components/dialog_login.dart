import 'package:flutter/material.dart';

Future genericDialog(
    BuildContext context, String title, String body, String buttonName) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          // define os botões na base do dialogo
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF7B2CBF)),
            ),
            child: Text(buttonName),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
