import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:time_wise_app/state_container.dart';

class ChecklistService {
  Future<ChecklistItem> createListItem(BuildContext context, listItem) async {
    var container = StateContainer.of(context);
    String _serviceUrl =
        '${container.getApiUrl()}/trip/${listItem.tripId}/list_items.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': container.getAppState().token.toString(),
    };

    try {
      var json = listItem.toJson();
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var newItem = ChecklistItem().fromJson(jsonDecode(response.body));
      return newItem;
    } catch (e) {
      print('Server exception');
      print(e);
      return null;
    }
  }
}

class ChecklistItem {
  int tripId;
  String body;

  ChecklistItem({this.tripId, this.body});

  // TODO: calls service to save list item, future
  void save() {}

  String toJson() {
    var mapData = new Map();
    mapData['trip_id'] = this.tripId;
    mapData['body'] = this.body;
    String json = jsonEncode(mapData);
    return json;
  }

  ChecklistItem fromJson(Map<String, dynamic> json) {
    this.tripId = json['trip_id'];
    this.body = json['body'];
  }
}
