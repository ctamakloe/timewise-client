import 'package:flutter/material.dart';
import 'package:time_wise_app/widgets/login_button.dart';
import 'package:time_wise_app/widgets/login_logo.dart';
import 'package:time_wise_app/widgets/login_navigation_link.dart';
import 'package:time_wise_app/widgets/login_text_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LoginLogo(),
                SizedBox(
                  height: 20.0,
                ),
                LoginTextField(
                  hintText: 'Name',
                  obscureText: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginTextField(
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginTextField(
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginButton('Sign up'),
                SizedBox(
                  height: 50.0,
                ),
                 LoginNavigationLink(
                     label: 'Return to Log in',
                     ontap: () => Navigator.of(context).pop()
                 ),
              ],
            )));
  }
}
