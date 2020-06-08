import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:time_wise_app/models/user.dart';
import 'package:time_wise_app/screens/login_signup_screen.dart';
import 'package:time_wise_app/state_container.dart';

class AuthService {
  static Future<User> sendSignupRequest(
      BuildContext context, String name, String email, String password) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/users.json';
    final _headers = {
      'Content-Type': 'application/json',
    };

    try {
      var json = jsonEncode({
        'user': {'name': name, 'email': email, 'password': password}
      });

      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);

      print(response.body);
      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      print('Server exception in createUser');
      print(e);
      return null;
    }
  }

  static Future<User> sendLoginRequest(
      BuildContext context, String email, String password) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/authenticate.json';
    final _headers = {
      'Content-Type': 'application/json',
    };

    try {
      var json = jsonEncode({'email': email, 'password': password});

      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);

//      print(response.body);

      User user = User.fromJson(jsonDecode(response.body)['user']);
      return user;
    } catch (e) {
      print('Server exception in login');
      print(e);
      return null;
    }
  }
}
