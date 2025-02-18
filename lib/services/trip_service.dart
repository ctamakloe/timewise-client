import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time_wise_app/models/station.dart';
import 'dart:async';
import 'dart:convert';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/state_container.dart';

class TripService {
  Future<List<Trip>> getTrips(String apiUrl, String authToken) async {
    String _serviceUrl = '$apiUrl/trips.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    };
    try {
      final response = await http.get(
        _serviceUrl,
        headers: _headers,
      );

      List<Trip> _trips = List<Trip>.from(jsonDecode(response.body)
          .map((json) => Trip.fromJson(json))
          .toList());

      print('getTrips (server) complete');
      return _trips;
    } catch (e) {
      print('Server exception in getTrips');
      print(e);
      return null;
    }
  }

  Future<Trip> createTrip(BuildContext context, TripFormData formData) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/trips.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': container.getAppState().token.toString(),
    };
    try {
      var json = formData.toJson();

      print(json);

      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);

      return Trip.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Server exception in createTrip');
      print(e);
      return null;
    }
  }

  Future<Trip> updateTrip(BuildContext context, Trip trip) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/trips/${trip.id}.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': container.getAppState().token.toString(),
    };

    try {
      final response =
          await http.put(_serviceUrl, headers: _headers, body: trip.toJson());

      return Trip.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Server exception in updateTrip');
      print(e);
      return null;
    }
  }

  Future<void> deleteTrip(BuildContext context, Trip trip) async {
    var container = StateContainer.of(context);
    String _serviceUrl = '${container.getApiUrl()}/trips/${trip.id}.json';
    final _headers = {
      'Content-Type': 'application/json',
      'Authorization': container.getAppState().token.toString(),
    };

    try {
      final response = await http.delete(
        _serviceUrl,
        headers: _headers,
      );
      return null;
    } catch (e) {
      print('Server exception in updateTrip');
      print(e);
      return null;
    }
  }
}

class TripFormData {
  int scheduleId;
  String tripType;
  String tripPurpose;
  String travelDirection;
  String rating;

  TripFormData(
      {this.scheduleId, this.tripType, this.travelDirection, this.tripPurpose});

  String toJson() {
//    String _tripFormToJson(TripFormData formData) {
    var mapData = new Map();
    mapData['train_schedule_id'] = this.scheduleId;
    mapData['trip_type'] = this.tripType;
    mapData['purpose'] = this.tripPurpose;
    mapData['travel_direction'] = this.travelDirection;
    mapData['rating'] = this.rating;
    String json = jsonEncode(mapData);
    return json;
  }
}
