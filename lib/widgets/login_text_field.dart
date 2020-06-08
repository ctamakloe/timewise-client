import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField({
    Key key,
    @required hintText,
    @required bool obscureText,
    @required controller,
    maxLines,
    keyboardType,
    autofocus,
    validator,
    onSaved,
  })  : hintText = hintText,
        controller = controller,
        obscureText = obscureText,
        maxLines = maxLines,
        keyboardType = keyboardType,
        autofocus = autofocus,
        validator = validator,
        onSaved = onSaved,
        super(key: key);

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;
  final bool autofocus;
  FormFieldValidator<String> validator;
  FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      autofocus: autofocus,
      validator: validator,
      onSaved: onSaved,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15.0),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
