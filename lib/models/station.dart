import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class Station {
  String code;
  String name;

  Station({this.code, this.name});
}
