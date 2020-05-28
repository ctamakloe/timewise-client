import 'package:flutter/material.dart';
import 'package:time_wise_app/components/coverage_chart.dart';
import 'package:time_wise_app/components/coverage_heat_map.dart';
import 'package:time_wise_app/components/heat_map.dart';
import 'package:time_wise_app/models/trip.dart';

class CoverageInfo extends StatefulWidget {
  CoverageInfo({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  @override
  _CoverageInfoState createState() => _CoverageInfoState();
}

class _CoverageInfoState extends State<CoverageInfo> {
  @override
  Widget build(BuildContext context) {

      return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [Text('select icon to show coverage')],
              ),
              Row(
                children: _getLegMaps(widget.trip),
              ),
            ],
          ),
        ));
  }

  _getLegMaps(Trip trip) {
    List<LegCoverageHeatMap> heatMaps = [];
    trip.tripLegs.forEach((leg) => heatMaps.add(LegCoverageHeatMap(leg)));
    return heatMaps;
  }
}

