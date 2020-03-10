import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    this.hintText,
    this.onPressed,
    this.onValidate,
    this.iconData,
    this.obscure: false,
  });
  final String hintText;
  final Function onPressed;
  final Function onValidate;
  final IconData iconData;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          iconData,
          color: Colors.yellow[500],
        ),
        errorStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        hintText: this.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow[100],
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
            width: 2.0,
          ),
        ),
      ),
      onChanged: this.onPressed,
      validator: this.onValidate,
    );
  }
}
