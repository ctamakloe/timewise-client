import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RouteHeatMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // compile a bunch of data columns to get the map for a leg
    return Column(
//        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            child: Row(
              children: [
                _stationColumn(),
                _dataColumn(),
                SizedBox(width: 10,),
                _dataColumn(),
                SizedBox(width: 10,),
                _dataColumn(),
                _stationColumn(),
              ],
            ),
          ),
          Container(
              width: 100.0,
              child: Center(child: Text('London St Pancras Intl (STP)'))),
        ]);
  }

  // CONTAINERS

  _ratingContainer() {
    return Container(
      height: 50.0,
      width: 50.0,
      color: Colors.green[100],
    );
  }

  _labelContainer() {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Text(
        '10:02',
      ),
    );
  }

  _nodeContainer() {
    return Container(
        height: 50.0,
        width: 50.0,
        color: Colors.white,
        child: Icon(
          LineAwesomeIcons.dot_circle,
        ));
  }

  _lineContainer() {
    return Container(
        height: 50.0,
        width: 50.0,
        color: Colors.white,
        child: Divider(
          thickness: 3.0,
        ));
  }

  _emptyContainer() {
    return Container(
      height: 50.0,
      width: 50.0,
      color: Colors.white,
    );
  }

/*
  _stationNameContainer() {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Text(
        'London St Pancras Intl',
      ),
    );
  }
*/

  // COLUMNS

  // represents a strength/time pair
  _dataColumn() {
    return Container(
      height: 150.0,
      width: 100.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _ratingContainer(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _labelContainer(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _lineContainer(),
          ),
        ],
      ),
    );
  }

  // represents the stations on the route
  _stationColumn() {
    return Column(
      children: [
        _emptyContainer(),
        _emptyContainer(),
        _nodeContainer(),
      ],
    );
  }
}
