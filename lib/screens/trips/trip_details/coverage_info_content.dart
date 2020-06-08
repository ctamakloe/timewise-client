import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/icon_tile.dart';
import 'package:time_wise_app/components/leg_heat_map.dart';
import 'package:time_wise_app/models/trip.dart';

class CoverageInfoContent extends StatefulWidget {
  CoverageInfoContent({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  @override
  _CoverageInfoContentState createState() => _CoverageInfoContentState();
}

class _CoverageInfoContentState extends State<CoverageInfoContent> {
  int _activeTileIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _optionTiles(),
            Divider(),
            IndexedStack(
              index: _activeTileIndex,
              children: [
                _routeHeatMap('phone'),
                _routeHeatMap('data'),
                _routeHeatMap('wifi')
              ],
            ),
            Divider(),
            _heatMapKey()
          ],
        ));
  }

  _optionTiles() {
    return Container(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _optionIconTile('phone', Icons.phone_in_talk, _activeTileIndex == 0),
          _optionIconTile(
              'data', LineAwesomeIcons.signal, _activeTileIndex == 1),
          _optionIconTile('wifi', Icons.wifi, _activeTileIndex == 2),
//          _optionIconTile('crowd', Icons.people, activeTile == 'crowd'),
        ],
      ),
    );
  }

  _optionIconTile(String option, IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: active
          ? BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 3.0, color: Colors.indigo),
            ))
          : null,
      child: IconTile(
        onTap: () {
          setState(() {
            //TODO: show data for option selected
            switch (option) {
              case 'phone':
                _activeTileIndex = 0;
                break;
              case 'data':
                _activeTileIndex = 1;
                break;
              case 'wifi':
                _activeTileIndex = 2;
                break;
            }
          });
        },
        icon: icon,
        iconColor: active ? Colors.indigo : null,
      ),
    );
  }

  _routeHeatMap(String type) {
    return Container(
      height: 180.0,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              widget.trip.tripLegs.map((leg) => LegHeatMap(leg, type)).toList(),
        ),
      ),
    );
  }

  _heatMapKey() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _keyColumn(Colors.grey[200], 'No Data'),
            SizedBox(
              width: 5,
            ),
            _keyColumn(Colors.green[100], 'Low'),
            SizedBox(
              width: 5,
            ),
            _keyColumn(Colors.green[200], 'Moderate'),
            SizedBox(
              width: 5,
            ),
            _keyColumn(Colors.green[300], 'Good'),
            SizedBox(
              width: 5,
            ),
            _keyColumn(Colors.green[400], 'Very Good'),
            SizedBox(
              width: 5,
            ),
            _keyColumn(Colors.green[500], 'Excellent'),
          ]),
    );
  }

  _keyColumn(Color color, String label) {
    return Container(
      height: 70,
      child: Column(
        children: [_keyColor(color), _keyLabel(label)],
      ),
    );
  }

  _keyColor(Color color) {
    return Container(
      height: 20,
      width: 50,
      color: color,
    );
  }

  _keyLabel(String labelText) {
    return Container(
      height: 20,
      width: 50,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text(
        labelText,
        style: TextStyle(
          fontSize: 10.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
