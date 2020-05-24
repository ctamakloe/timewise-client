import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;

  LoginButton(this.label);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(15.0),
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
