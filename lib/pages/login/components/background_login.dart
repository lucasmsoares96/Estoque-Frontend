import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ComponentBackgroundImageLogin extends StatelessWidget {
  const ComponentBackgroundImageLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Container(
        width: _width,
        height: _height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFF9D4EDD),
              Color(0xFFE0AAFF)
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('images/logo.png',),
            ),
            Expanded(
              child: Image.asset("images/estoque.jpg", fit: BoxFit.cover, width: _width,),
            )
          ],
        ),
      );
  }
}