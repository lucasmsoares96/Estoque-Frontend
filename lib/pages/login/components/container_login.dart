import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContainerLogin extends StatelessWidget {
  final double width;
  final double height;
  final Widget childContent;
  const ContainerLogin(
      {Key? key,
      required this.height,
      required this.width,
      required this.childContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width * 0.3,
        height: height,
        margin: EdgeInsets.symmetric(vertical: height * 0.1),
        padding: EdgeInsets.symmetric(vertical: width * 0.04, horizontal: width * 0.03),
        constraints: const BoxConstraints(
          maxWidth: 600,
          minWidth: 300,
          maxHeight: 800,
          minHeight: 500,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: childContent);
  }
}
