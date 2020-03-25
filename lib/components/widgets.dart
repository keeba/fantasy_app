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
    return Container(
      child: TextFormField(
        obscureText: obscure,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            iconData,
            color: Colors.yellow[500],
          ),
          errorStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0XFF8B0000),
          ),
          hintText: this.hintText,
        ),
        onChanged: this.onPressed,
        validator: this.onValidate,
      ),
    );
  }
}
