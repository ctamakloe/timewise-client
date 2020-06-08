import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:time_wise_app/models/api/api_train_schedule.dart';
import 'package:http/http.dart' as http;
import 'package:time_wise_app/services/auth_service.dart';
import 'package:time_wise_app/state_container.dart';

class TrainScheduleService {
  Future<List<APITrainSchedule>> getTrainSchedules(BuildContext context,
      String startStation, String endStation, String date, String time) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/schedules.json?'
        'start_station=$startStation'
        '&end_station=$endStation'
        '&date=$date'
        '&time=$time';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': container.getAppState().token.toString(),
    };

    try {
      final response = await http.get(_serviceUrl, headers: _headers);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((i) => APITrainSchedule.fromJson(i))
            .toList();
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//    static Future<List<APITrainSchedule>> getTrainSchedules(String startStation,
//    String endStation, String date, String time) async {
//    String url = 'http://localhost:3000/schedules.json?'
//    'start_station=$startStation'
//    '&end_station=$endStation'
//    '&date=$date'
//    '&time=$time';
//
//    List<APITrainSchedule> schedules = [];
//    final response = await http.get(url);
//    if (response.statusCode == 200) {
//    schedules = (json.decode(response.body) as List)
//        .map((i) => APITrainSchedule.fromJson(i))
//        .toList();
//    } else {
//    print('Request failed with status: ${response.statusCode}.');
//    }
//    return schedules;
//    }
}
