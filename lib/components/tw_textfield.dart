import 'package:flutter/material.dart';

class TWTextField extends StatelessWidget {
  final Function onChanged;
  final String labelText;
  final IconData icon;

  TWTextField({this.labelText, this.icon, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.indigo,
              )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}
