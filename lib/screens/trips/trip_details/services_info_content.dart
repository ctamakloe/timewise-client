import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_wise_app/components/icon_tile.dart';
import 'package:time_wise_app/models/trip.dart';

class ServicesInfoContent extends StatelessWidget {
  const ServicesInfoContent({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 100.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _serviceInfoTile(context, LineAwesomeIcons.wifi, 'How to access WiFi'),
        _serviceInfoTile(context, LineAwesomeIcons.plug, 'Where to find charging points'),
        _serviceInfoTile(context, LineAwesomeIcons.utensils, 'Catering info'),
        _serviceInfoTile(context, LineAwesomeIcons.toilet, 'Toilet information'),
        _serviceInfoTile(context, LineAwesomeIcons.accessible_icon, 'Accessibility options'),
        _serviceInfoTile(context, LineAwesomeIcons.biking, 'Bike storage'),
      ]),
    );
  }

  Widget _serviceInfoTile(BuildContext context, IconData icon, String info) {
    return IconTile(
      onTap: () => _showServiceInfo(context, info),
      icon: icon,
    );
  }

  _showServiceInfo(BuildContext context, String info) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.all(30.0),
            child: Text(info),
          );
        });
  }
}
