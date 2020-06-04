import 'dart:convert';

import 'package:time_wise_app/models/api/api_train_schedule.dart';
import 'package:http/http.dart' as http;

class TrainScheduleService {
  Future<List<APITrainSchedule>> getTrainSchedules(
      String startStation, String endStation, String date, String time) async {

    String _serviceUrl = 'http://localhost:3000/schedules.json?'
        'start_station=$startStation'
        '&end_station=$endStation'
        '&date=$date'
        '&time=$time';

    final _headers = {
      'Content-Type': 'application/json',
      'Authorization':
          ' eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1OTEzNjExMzh9.BjfdStNCX3p7wQXk_XSxakz1oX6KBJ-IztUznnf28kw'
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
