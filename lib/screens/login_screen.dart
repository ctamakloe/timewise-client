import 'package:flutter/material.dart';
import 'package:time_wise_app/widgets/login_button.dart';
import 'package:time_wise_app/widgets/login_logo.dart';
import 'package:time_wise_app/widgets/login_navigation_link.dart';
import 'package:time_wise_app/widgets/login_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15.0),
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginLogo(),
            SizedBox(height: 40.0),
            LoginTextField(
              hintText: 'Username',
              obscureText: false,
            ),
            SizedBox(height: 20.0),
            LoginTextField(
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            LoginButton('Log in'),
            SizedBox(
              height: 50.0,
            ),
             LoginNavigationLink(
                 label: 'Sign up',
                 ontap: () => Navigator.of(context).pushNamed('/signup')
             ),
          ],
        ),
      ),
    );
  }
}
