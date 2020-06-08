import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;

  LoginButton({this.labelText, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(15.0),
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
