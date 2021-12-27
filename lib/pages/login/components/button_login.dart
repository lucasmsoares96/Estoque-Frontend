import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ComponentButtonLogin extends StatelessWidget {
  final Future<void> Function()? onPressed; 
  final void Function() changeLoadingStatus; 
  final bool loading;
  final double width;
  final String text;
  const ComponentButtonLogin({ 
    Key? key, 
    required this.text, 
    required this.loading , 
    required  this.changeLoadingStatus, 
    this.onPressed, 
    required this.width }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed != null
      ? () async{ 
        changeLoadingStatus();
        await onPressed!();
        changeLoadingStatus();        
      }
      : null,
      child: Container(
        width: width,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF5A189A)),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: loading
          ?  const CircularProgressIndicator(color: Color(0xFF5A189A) ,)
          : Text(text, textAlign: TextAlign.center, style: const TextStyle(color:Color(0xFF5A189A), fontSize: 18 ),),
        ),
      ),

    );
  }
}