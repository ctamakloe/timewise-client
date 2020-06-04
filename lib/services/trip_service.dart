import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:time_wise_app/models/trip.dart';

class TripService {
  Future<Trip> createTrip(TripFormData formData) async {
    const _serviceUrl = 'http://localhost:3000/trips.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization':
          ' eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1OTEzNjExMzh9.BjfdStNCX3p7wQXk_XSxakz1oX6KBJ-IztUznnf28kw'
    };
    try {
      var json = _tripFormToJson(formData);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var trip = Trip.fromJson(jsonDecode(response.body));
      return trip;
    } catch (e) {
      print('Server exception');
      print(e);
      return null;
    }
  }

  String _tripFormToJson(TripFormData formData) {
    var mapData = new Map();
    mapData['train_schedule_id'] = formData.scheduleId;
    mapData['trip_type'] = formData.tripType;
    mapData['purpose'] = formData.tripPurpose;
    mapData['travel_direction'] = formData.travelDirection;
    String json = jsonEncode(mapData);
    return json;
  }
}

class TripFormData {
  int scheduleId;
  String tripType;
  String tripPurpose;
  String travelDirection;

  TripFormData(
      {this.scheduleId, this.tripType, this.travelDirection, this.tripPurpose});
}
