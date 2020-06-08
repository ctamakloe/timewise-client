import 'package:flutter/material.dart';
import 'package:time_wise_app/services/auth_service.dart';
import 'package:time_wise_app/state_container.dart';
import 'package:time_wise_app/widgets/login_button.dart';
import 'package:time_wise_app/widgets/login_logo.dart';
import 'package:time_wise_app/widgets/login_text_field.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _formKey = new GlobalKey<FormState>();

//  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;

  String _name;
  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      try {
        if (_isLoginForm) {
          AuthService.sendLoginRequest(context, _email, _password)
              .then((user) {
            if (user != null) StateContainer.of(context).login(user);
          });
        } else {
          AuthService.sendSignupRequest(context, _name, _email, _password)
              .then((user) {
            if (user != null) {
              StateContainer.of(context).login(user);
            }
          });
        }
        setState(() {
          _isLoading = false;
        });

//        if (userId.length > 0 && userId != null && _isLoginForm) {
//          widget.loginCallback();
//        }

//        if (token != null && token.length > 0 && _isLoginForm) {
//          setState(() {
//            authStatus = AuthStatus.LOGGED_IN;
//          });
//        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _showForm(),
//        _showCircularProgress(),
      ],
    ));
  }

  Widget _showForm() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 60.0),
              child: LoginLogo(),
            ),
            if (!_isLoginForm)
              LoginTextField(
                hintText: 'Name',
                autofocus: false,
                obscureText: false,
                maxLines: 1,
                validator: (value) =>
                    value.isEmpty ? 'Name can\'t be empty' : null,
                onSaved: (value) => _name = value.trim(),
              ),
            SizedBox(height: 10.0),
            LoginTextField(
              hintText: 'Email',
              autofocus: false,
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => _email = value.trim(),
            ),
            SizedBox(height: 10.0),
            LoginTextField(
              hintText: 'Password',
              obscureText: true,
              autofocus: false,
              maxLines: 1,
              validator: (value) =>
                  value.isEmpty ? 'Password can\'t be empty' : null,
              onSaved: (value) => _password = value.trim(),
            ),
            SizedBox(
              height: 20.0,
            ),
            showPrimaryButton(),
            showSecondaryButton(),
            showErrorMessage(),
            /*
            */
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showPrimaryButton() {
    return LoginButton(
      labelText: _isLoginForm ? 'Log in' : 'Create account',
      onPressed: validateAndSubmit,
    );
  }

  Widget showSecondaryButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
      child: FlatButton(
          child: new Text(
              _isLoginForm ? 'Create an account' : 'Have an account? Log in',
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white)),
          onPressed: toggleFormMode),
    );
  }
}
