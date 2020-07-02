import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validate;
  final Function onSaved;
  final Function onChanged;
  final bool isEmail;
  final bool isPassword;

  MyTextFormField(
      {this.onSaved,
      this.hintText,
      this.isEmail = false,
      this.isPassword = false,
      this.validate,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey,
        ),
        obscureText: isPassword ? true : false,
        validator: validate,
        onSaved: onSaved,
        onChanged: onChanged,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
