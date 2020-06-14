import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_wise_app/services/trip_service.dart';

class Trip {
  int id;

//  String origin;
//  String destination;
  String originStationName;
  String originStationCode;
  String destinationStationName;
  String destinationStationCode;
  String departsAt;
  String arrivesAt;
  String type;
  String purpose;
  String travelDirection;
  String status;
  String rating;
  List<TripLeg> tripLegs = sampleTripLegs;

  Trip(
      {this.id,
      this.originStationName,
      this.originStationCode,
      this.destinationStationName,
      this.destinationStationCode,
      this.departsAt,
      this.arrivesAt,
      this.type,
      this.purpose,
      this.travelDirection,
      this.rating,
      this.status}) {
//    initializeDateFormatting('de_DE', null).then(formatDates);
  }

  String get title =>
      '${this.originStationName} to ${this.destinationStationName}';

  String get schedule {
    String dt = DateFormat.Hm().format(DateTime.parse(departsAt));
    String at = DateFormat.Hm().format(DateTime.parse(arrivesAt));
    return '$dt - $at';
  }

  String get date => DateFormat.yMMMMd().format(DateTime.parse(departsAt));

  bool isBusiness() => this.type == 'business';

  bool isOutbound() => this.travelDirection == 'outbound';

  bool isUpcoming() => this.status == 'upcoming';

  bool isInProgress() => this.status == 'in-progress';

  bool isCompleted() => this.status == 'completed';

  String get purposeDescription =>
      '${this.purpose} ${this.isOutbound() ? '' : '(Return)'} ';

  void start() => this.status = 'in-progress';

  void end() => this.status = 'completed';

  update(BuildContext context) {
    return TripService().updateTrip(context, this);
  }

  delete(BuildContext context) {
    return TripService().deleteTrip(context, this);
  }

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
//    origin = json['origin'];
//    destination = json['destination'];
    originStationName = json['origin_station_name'];
    originStationCode = json['origin_station_code'];
    destinationStationName = json['destination_station_name'];
    destinationStationCode = json['destination_station_code'];
    departsAt = json['departs_at'];
    arrivesAt = json['arrives_at'];
    type = json['trip_type'];
    purpose = json['purpose'];
    travelDirection = json['travel_direction'];
    rating = json['rating'];
    status = json['status'];
  }

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['origin'] = this.origin;
//    data['destination'] = this.destination;
    data['origin_station_name'] = this.originStationName;
    data['origin_station_code'] = this.originStationCode;
    data['destination_station_name'] = this.destinationStationName;
    data['destination_station_code'] = this.destinationStationCode;
    data['departs_at'] = this.departsAt;
    data['arrives_at'] = this.arrivesAt;
    data['trip_type'] = this.type;
    data['purpose'] = this.purpose;
    data['travel_direction'] = this.travelDirection;
    data['rating'] = this.rating;
    data['status'] = this.status;
    String json = jsonEncode(data);
    return json;
  }

  static List<Trip> sampleInProgressTrips =
      inProgressTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<Trip> sampleUpcomingTrips =
      upcomingTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<Trip> sampleCompleteTrips =
      completeTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<Trip> allTrips =
      tripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<TripLeg> sampleTripLegs = [
    TripLeg(
        startStation: 'Nottingham',
        endStation: 'Beeston',
        legType: 'departure',
//        stopTime: '11:00',
        dataCells: [
          TripLegDataCell('11:00', 10, '5'),
          TripLegDataCell('11:08', 10, '5'),
        ]),
    TripLeg(
        startStation: 'Beeston',
        endStation: 'Loughborough',
        legType: 'transit',
//        stopTime: '11:09',
        dataCells: [
          TripLegDataCell('11:09', 10, '5'),
          TripLegDataCell('11:10', 10, '5'),
        ]),
    TripLeg(
        startStation: 'Loughborough',
        endStation: 'Leicester',
        legType: 'transit',
//        stopTime: '11:19',
        dataCells: [
          TripLegDataCell('11:19', 10, '4'),
          TripLegDataCell('11:27', 10, '4'),
          TripLegDataCell('11:37', 10, '3')
        ]),
    TripLeg(
        startStation: 'Leicester',
        endStation: 'Market Harborough',
        legType: 'transit',
//        stopTime: '11:38',
        dataCells: [
          TripLegDataCell('11:38', 10, '3'),
          TripLegDataCell('11:48', 10, '3'),
          TripLegDataCell('11:50', 10, '3'),
        ]),
    TripLeg(
        startStation: 'Market Harborough',
        endStation: 'Kettering',
        legType: 'transit',
//        stopTime: '11:51',
        dataCells: [
          TripLegDataCell('11:51', 10, '2'),
          TripLegDataCell('12:00', 10, '2')
        ]),
    TripLeg(
        startStation: 'Kettering',
        endStation: 'Wellingborough',
        legType: 'transit',
//        stopTime: '12:01',
        dataCells: [
          TripLegDataCell('12:01', 10, '2'),
          TripLegDataCell('12:07', 10, '2')
        ]),
    TripLeg(
        startStation: 'Wellingborough',
        endStation: 'Bedford',
        legType: 'transit',
//        stopTime: '12:08',
        dataCells: [
          TripLegDataCell('12:08', 10, '1'),
          TripLegDataCell('12:21', 10, '1')
        ]),
    TripLeg(
        startStation: 'Bedford',
        endStation: 'Luton Airport Parkway',
        legType: 'transit',
//        stopTime: '12:22',
        dataCells: [
          TripLegDataCell('12:22', 10, '0'),
          TripLegDataCell('12:32', 10, '0'),
          TripLegDataCell('12:37', 10, '0')
        ]),
    TripLeg(
        startStation: 'Luton Airport Parkway',
        endStation: 'London St Pancras',
        legType: 'arrival',
//        stopTime: '12:38',
        dataCells: [
          TripLegDataCell('12:38', 10, '1'),
          TripLegDataCell('12:48', 10, '1'),
          TripLegDataCell('12:58', 10, '1'),
          TripLegDataCell('13:08', 10, '1'),
          TripLegDataCell('13:10', 10, '1')
        ]),
  ];
}

class TripLeg {
  String startStation;
  String endStation;
  String legType;

//  String stopTime;
  List<TripLegDataCell> dataCells;

  TripLeg({
    this.startStation, // Nottingham
    this.endStation, // London St Pancras Intl
//    this.stopTime,
    this.legType, // departure, transit, arrival
    this.dataCells, // <TripLegDataCell>[]
  });
// NB: create a var legDuration => used on server side to calculate no. of cells to be
// generated
}

class TripLegDataCell {
  String timeLabel;
  int duration;
  String rating;

  TripLegDataCell(this.timeLabel, this.duration, this.rating);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

List<Map<String, Object>> inProgressTripsJson = [
  {
    "id": 1,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "trip_type": "non-business",
    "purpose": "Visit Sean at Uni",
    "rating": 0,
    "status": "in-progress"
  },
];

List<Map<String, Object>> upcomingTripsJson = [
  {
    "id": 2,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "Return: Meeting at ABC Head Office",
    "rating": 1,
    "status": "upcoming"
  },
  {
    "id": 3,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "leisure",
    "purpose": "Vegan meet-up in Notts",
    "rating": 1,
    "status": "upcoming"
  },
  {
    "id": 4,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "SXSW Conference",
    "rating": 1,
    "status": "upcoming"
  }
];

List<Map<String, Object>> completeTripsJson = [
  {
    "id": 5,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "trip_type": "leisure",
    "purpose": "Visit Sean at Uni",
    "rating": 3,
    "status": "completed"
  },
  {
    "id": 6,
    "origin": "Nottingham",
    "destination": "London St Pancras International",
    "departs_at": "2020-05-25T07:10:46.120Z",
    "arrives_at": "2000-01-01T09:05:46.120Z",
    "trip_type": "business",
    "purpose": "Meeting at ABC head office",
    "rating": 5,
    "status": "completed"
  },
  {
    "id": 7,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "Return: Meeting at ABC Head Office",
    "rating": 2,
    "status": "completed"
  },
  {
    "id": 8,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "leisure",
    "purpose": "Vegan meet-up in Notts",
    "rating": 1,
    "status": "completed"
  },
  {
    "id": 9,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "SXSW Conference",
    "rating": 3,
    "status": "completed"
  }
];

List<Map<String, Object>> tripsJson = [
  {
    "id": 1,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "trip_type": "non-business",
    "purpose": "Visit Sean at Uni",
    "rating": 0,
    "status": "in-progress"
  },
  {
    "id": 2,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "Return: Meeting at ABC Head Office",
    "rating": 1,
    "status": "upcoming"
  },
  {
    "id": 3,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "leisure",
    "purpose": "Vegan meet-up in Notts",
    "rating": 1,
    "status": "upcoming"
  },
  {
    "id": 4,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "SXSW Conference",
    "rating": 1,
    "status": "upcoming"
  },
  {
    "id": 5,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "trip_type": "leisure",
    "purpose": "Visit Sean at Uni",
    "rating": 3,
    "status": "completed"
  },
  {
    "id": 6,
    "origin": "Nottingham",
    "destination": "London St Pancras International",
    "departs_at": "2020-05-25T07:10:46.120Z",
    "arrives_at": "2000-01-01T09:05:46.120Z",
    "trip_type": "business",
    "purpose": "Meeting at ABC head office",
    "rating": 5,
    "status": "completed"
  },
  {
    "id": 7,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "Return: Meeting at ABC Head Office",
    "rating": 2,
    "status": "completed"
  },
  {
    "id": 8,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "leisure",
    "purpose": "Vegan meet-up in Notts",
    "rating": 1,
    "status": "completed"
  },
  {
    "id": 9,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "trip_type": "business",
    "purpose": "SXSW Conference",
    "rating": 3,
    "status": "completed"
  }
];
