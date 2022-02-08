import 'package:flutter/material.dart';

class ComponentTextfieldLogin extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextInputType? textInputType;
  final bool obscure;
  final double leftPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onEditingComplete;
  final Function? onTap;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final int maxLines;
  final String? errorText;
  final bool activateError;
  final TextInputAction textInputAction;
  final bool enabled;

  const ComponentTextfieldLogin(
      {Key? key,
      this.label,
      this.onTap,
      this.activateError = false,
      this.hint,
      this.controller,
      this.initialValue,
      this.textInputType,
      this.obscure = false,
      this.leftPadding = 5,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.onSaved,
      this.maxLines = 1,
      this.onEditingComplete,
      this.errorText,
      this.enabled = true,
      this.textInputAction = TextInputAction.done,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onEditingComplete: () =>
            onEditingComplete != null ? onEditingComplete!() : null,
        onTap: () => onTap != null ? onTap!() : null,
        controller: controller,
        initialValue: initialValue,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        enabled: enabled,
        obscureText: obscure,
        onSaved: onSaved,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
            errorText: activateError ? errorText : null,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: maxLines == 1
                ? EdgeInsets.only(left: leftPadding, top: 15)
                : const EdgeInsets.all(15),
            labelText: label,
            labelStyle: textStyle,
            hintText: hint,
            hintStyle: textStyle,
            enabledBorder: maxLines == 1
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  )
                : OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(16)),
            focusedBorder: maxLines == 1
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  )
                : OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(16)),
            errorBorder: maxLines == 1
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  )
                : OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(16))),
      ),
    );
  }
}
