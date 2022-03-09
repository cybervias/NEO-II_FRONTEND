import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Widget icon;
  String hint;
  bool password;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  FocusNode? nextFocus;

  AppText(
    this.text,
    this.icon,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        controller: controller,
        obscureText: password,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: (text) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
          prefixIcon: icon,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
